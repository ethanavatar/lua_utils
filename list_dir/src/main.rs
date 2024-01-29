use std::env;
use std::io::{self, Write};
use std::path::PathBuf;

fn get_files(dir: &str, recursive: bool) -> Vec<PathBuf> {
    let files = std::fs::read_dir(dir)
        .expect("Failed to read directory")
        .filter_map(|x| x.ok())
        .map(|x| x.path())
        .collect::<Vec<_>>();

    if !recursive {
        return files;
    }

    let mut all_files = files.clone();
    for file in files.iter() {
        if !file.is_dir() {
            continue;
        }

        let sub_files = get_files(file.to_str().unwrap(), recursive);
        all_files.extend(sub_files);
    }

    return all_files;
}

fn main() {
    let stdout = io::stdout();

    let args: Vec<String> = env::args().collect();
    let dir = &args
        .get(1)
        .expect("No directory provided");

    let recursive = args
        .get(2)
        .map(|x| x == "-r")
        .unwrap_or(false);

    let files = get_files(dir, recursive);

    let mut stdout = stdout.lock();

    for file in files {
        writeln!(stdout, "{}", file.display()).unwrap();
    }

    stdout.flush().unwrap();
}
