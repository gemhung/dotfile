extern crate proc_macro;

use proc_macro::TokenStream;
use quote::quote;
use syn::parse_macro_input;
use syn::DataStruct;
use syn::DeriveInput;

// using proc_macro_attribute to declare an attribute like procedural macro
#[proc_macro_derive(LoadConf)]
// // _metadata is argument provided to macro call and _input is code to which attribute like macro attaches
pub fn load_conf(input: TokenStream) -> TokenStream {
    let input = parse_macro_input!(input as DeriveInput);
    let syn::Data::Struct(DataStruct { ref fields, .. }) = input.data else {
        panic!("Unknown struct");
    };
    let vec = fields.iter().map(|f| {
        let syn::Type::Path(syn::TypePath {path: syn::Path { segments, .. }, ..}) = &f.ty else {
            panic!("Unknown type");
        };
        let ident = &f.ident;
        let arguments = segments.first().map(|inner| &inner.arguments);
        match arguments {
            // For Vec<T>
            Some(syn::PathArguments::AngleBracketed(
                syn::AngleBracketedGenericArguments { .. },
            )) => {
                quote! {
                    #ident:
                        map
                          .get(stringify!(#ident))
                          .ok_or_else(|| anyhow::anyhow!("No suhc key({})", stringify!(#ident)))
                          .and_then(|vec|{
                              vec
                                .iter()
                                .map(|inner|inner.as_str().parse().map_err(anyhow::Error::new))
                                .collect::<Result<Vec<_>, _>>()
                          })?,
                }
            }
            // POD type such as usize, f64, String, ... etc
            _ => {
                let ty = &f.ty;
                quote! {
                    #ident:
                      map
                        .get(stringify!(#ident))
                        .ok_or_else(|| anyhow::anyhow!("No suhc key({})", stringify!(#ident)))
                        .and_then(|vec| {
                            match (vec.len(), vec.first()) {
                                (1, Some(val)) => Ok(val),
                                _ => Err(anyhow::anyhow!("Multi values found but {} isn't `Vec`, consider using Vec<{}>", stringify!(#ty), stringify!(#ty))),
                            }
                        })
                        .and_then(|val| val.as_str().parse().map_err(anyhow::Error::new))?,
                }
            }
        }
    })
    .collect::<Vec<_>>();

    let ident = input.ident;
    let expanded = quote! {
        impl #ident {
            fn load() -> Result<Self, anyhow::Error> {
                use nom::{
                    bytes::complete::take_while_m_n, character::complete::anychar, character::complete::one_of,
                    combinator::map_res, error::ErrorKind, sequence::tuple, IResult,
                };

                use nom::branch::alt;
                use nom::bytes::complete::is_a;
                use nom::bytes::complete::tag;
                use nom::bytes::complete::take;
                use nom::bytes::complete::take_while1;
                use nom::character::complete::alpha1;
                use nom::character::complete::alphanumeric1;
                use nom::character::complete::char;
                use nom::character::complete::line_ending;
                use nom::character::complete::multispace0;
                use nom::character::complete::multispace1;
                use nom::character::complete::satisfy;
                use nom::character::complete::space0;
                use nom::character::complete::space1;
                use nom::character::is_alphabetic;
                use nom::character::is_newline;
                use nom::character::is_space;
                use nom::combinator::not;
                use nom::combinator::recognize;
                use nom::error::ParseError;
                use nom::multi::many0_count;
                use nom::multi::many1;
                use nom::sequence::delimited;
                use nom::sequence::pair;
                use nom::sequence::preceded;
                use nom::sequence::separated_pair;
                use nom::AsChar;
                use nom::Err;
                use nom::InputTakeAtPosition;
                use nom::Parser;
                pub fn all_but_space<T, E: ParseError<T>>(input: T) -> IResult<T, T, E>
                where
                    T: InputTakeAtPosition,
                    <T as InputTakeAtPosition>::Item: AsChar,
                {
                    input.split_at_position1_complete(|item| item.as_char() == ' ', ErrorKind::Space)
                }

                pub fn rust_identifier(input: &str) -> IResult<&str, &str> {
                    recognize(pair(
                        //alt((alpha1, tag("_"))),
                        alpha1,
                        many0_count(alt((alphanumeric1, tag("_")))),
                    ))(input)
                }

                fn parse(text: &str) -> Result<std::collections::HashMap<String, Vec<String>>, anyhow::Error> {
                    let mut lines = text.lines();
                    let mut is_blank_line = not(preceded(space0::<&str, nom::error::Error<_>>, anychar));

                    let mut comment_parser = preceded(
                        space0::<&str, nom::error::Error<_>>,
                        take(1usize).and_then(|inner| is_a(";#")(inner)),
                    );

                    let mut keyval_parser = separated_pair(
                        delimited(space0, rust_identifier, space0),
                        nom::character::complete::char('='),
                        many1(delimited(
                            multispace0,
                            all_but_space::<_, nom::error::Error<_>>,
                            multispace0,
                        )),
                    );

                    let mut ret = std::collections::HashMap::new();
                    while let Some(line) = lines.next() {
                        if is_blank_line(line).is_ok() {
                            continue;
                        }
                        if comment_parser(line).is_ok() {
                            continue;
                        }
                        if let Ok((_remain, (key, value))) = keyval_parser(line) {
                            ret.insert(key.to_string(), value.iter().map(ToString::to_string).collect::<Vec<_>>());
                        }
                    }

                    Ok(ret)
                }
                let text = std::fs::read_to_string("./config.conf")?;
                let mut map = parse(&text)?;
                Ok(Self {
                    #(#vec)*
                })
            }
        }
    };

    TokenStream::from(expanded)
}
