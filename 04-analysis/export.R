INPUT <- "checkpoint/plot_04.RData"
OUTPUT <- "output/output_04.pptx"
TEMPLATE <- "<path to template>.pptx"

load(INPUT)

mydoc = pptx(title = "My Analysis", template = TEMPLATE)

mydoc %<>%
  addSlide(slide.layout = "Title and Content") %>%
  addTitle("A plot of some data") %>% 
  addPlot(function( ) print( myplot ) )

mydoc %<>%
  addSlide(slide.layout = "Two Content") %>%
  addTitle("A pair of plots") %>% 
  addPlot(function( ) print( myplot ) ) %>%
  addPlot(function( ) print( myplot ) )

writeDoc(mydoc, file = OUTPUT)
