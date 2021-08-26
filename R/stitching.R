library(magrittr)

cheatsheets_page <- rvest::read_html("https://github.com/rstudio/cheatsheets")

cheatsheets_list <- cheatsheets_page %>%
  rvest::html_nodes(".Link--primary") %>%
  rvest::html_text() %>%
  stringr::str_subset(".pdf") %>%
  stringr::str_replace_all(" ", "%20")
  

purrr::walk(cheatsheets_list, ~ download.file(url = paste0("https://github.com/rstudio/cheatsheets/raw/master/", .x),
              destfile = paste0(here::here("download/"), .x)))

staplr::staple_pdf(
  input_directory = here::here("download"),
  output_filepath = here::here("all_cheatsheets.pdf")
)
