#![allow(unused)]
use macro_demo::*;

// macro converts struct S to struct H
#[derive(Debug, Default, LoadConf)]
struct Config {
    pub token1: usize,
    pub token2: Vec<String>,
}

#[test]
fn test_macro() -> Result<(), anyhow::Error> {
    let demo = Config::load()?;
    println!("{:?}", demo);
    Ok(())
}
