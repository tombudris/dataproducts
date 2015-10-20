library(shiny)

shinyUI(
  pageWithSidebar(
    headerPanel('Blood Alcohol Content Estimator'),
#------------------------------------------------------------------------------  
    sidebarPanel(
      h2('Inputs'),
      numericInput('weight', 'Weight (lbs)', 180, min = 100, max = 300, step = 5),
      selectInput('sex', 'Sex', choices = list('male'= 'male', 'female'='female')),
      numericInput('drinks', 'Drinks', 1, min=1, max=10, step=1),
      numericInput('ctime', 'Timespan (hours)', 1, min=0, max=6, step=0.5),
      submitButton('Calculate')
    ),

    mainPanel(
      tabsetPanel( 
        tabPanel('Output', 
          h2('Estimated blood alcohol content'),
          h4('(% by volume) at the end of the specified time span:'),
          verbatimTextOutput('prediction'),
          h4('Based on input values of: '),
          verbatimTextOutput('inputValues'),
          p('NOTE: The legal limit for impaired driving in the U.S. is 0.08% BAC.')
        ),
        tabPanel('Help',
          p('This calculator is based on the Widmark formula for estimating blood 
            alcohol content (BAC). A detailed discussion of this parametric estimation 
            technique, including examples, can be found at:', a('http://www.ndaa.org/pdf/toxicology_final.pdf',
            href='http://www.ndaa.org/pdf/toxicology_final.pdf')),
          p('The formula estimates the volumetric ratio of alcohol consumed to the 
            blood volume (based on male/female averages) as a function of body weight. 
            It further estimates the amount of alcohol metabolized over the specified 
            timeframe, also based on male/female averages. Note that this is a very 
            coarse estimate, as specific body water composition and metabolic rates 
            will vary by individual beyond the parameters used here.'),
          h4('Weight'),
          p("The subject's weight in pounds. Must be entered as a positive numeric 
            value. For metric users, recall that one kilogram is approximately 
            2.2 pounds."),
          h4('Sex'),
          p("'male' or 'female'.  This controls internal assignment of typical body 
            water percentage, and alcohol metabolism rates, averaged per sex."),
          h4('Drinks'),
          p('The number of "standard U.S." drinks, which equates to 14 grams of pure 
            alcohol.  This is a typical measure for a 1.5 oz shot of 80 proof liquor, 
            a glass of wine, or a pint of beer. Must be entered as a non-negative 
            numeric value.'),
          h4('Timespan'),
          p("The amount of time, in hours, covering the period between consumption 
            and the BAC estimate calcuation. Must be entered as a non-negative numeric 
            value. The model effectively computes an instantaneous BAC (where all alcohol  
            was consumed simultaneously) and then decays this over the timeframe. This 
            approach generates a worst-case (upper bound) BAC (as opposed to a lower 
            estimate that would result from consumption staggered over time).")
        ) ## tabPanel
      ) ## tabsetPanel
    ) ## mainPanel
  ) ## pageWithSidebar
) ## shinyUI
