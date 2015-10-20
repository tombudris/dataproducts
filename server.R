library(shiny)
setwd('/Users/tom/Desktop/JHU Data Science/9-data products/project')

## Source: http://www.ndaa.org/pdf/toxicology_final.pdf
## Other notes:
##   - all calculations done in grams
##   - 14 g pure alcohol per "standard US" drink
##   - 2.2 lbs/kg, 1000 g/kg
##   - multiply by 100 to generate a percentage from the ratio

EBAC <- function(drinks, bodywater, weight, metab, ctime) 
  max(0, (100*(14 * drinks)/(bodywater*weight*1000/2.2)-(metab*ctime)))
## run the outcome through max(0,X), since negative results may be computed

shinyServer(
  function(input, output) {
    ## some parameters are dependent on sex... set them here as reactive
    bodywater <- reactive({as.numeric(if (input$sex=='male') 0.68 else 0.55)})
    metab <- reactive({as.numeric(if (input$sex=='male') 0.015 else 0.017)})
    output$prediction <- renderPrint({round(EBAC(input$drinks, bodywater(), 
                                                 input$weight, metab(), input$ctime),3)})
    output$inputValues <- renderPrint(c(Weight=input$weight, Sex=input$sex,
                                        Drinks=input$drinks, Timespan=input$ctime))
    }
)
