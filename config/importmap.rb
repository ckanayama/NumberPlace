# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin_all_from "app/javascript/canvas", under: "canvas"
pin_all_from "app/javascript/puzzles", under: "puzzles"
