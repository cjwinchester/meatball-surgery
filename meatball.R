library('rvest')

setwd('~/meatball')

term <- 'meatball surgery'
outfile <- 'meatball.txt'
url <- 'https://www.springfieldspringfield.co.uk/episode_scripts.php?tv-show=mash'
basepage <- read_html(url)
links <- html_nodes(basepage, 'a.season-episode-title') %>% html_attr('href')

has_meatball <- function(text) {
  return(grepl(term, text, ignore.case=TRUE))
}

for (link in links) {
  absolute_url <- paste0('https://www.springfieldspringfield.co.uk/', link)
  epname = unlist(strsplit(link, 'episode='))[2]
  print(epname)
  html <- read_html(absolute_url)
  htmltext <- html_text(html)
  write(htmltext, paste0(epname, '.html'))
  if (has_meatball(htmltext)) {
    print(absolute_url)
    write(absolute_url, outfile, append=TRUE)
  }
  Sys.sleep(2)
}