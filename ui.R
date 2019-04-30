title <- tags$a(href='https://www.google.com',
                tags$img(src = "xxi.png", height = '50', width = '200'))
header <- dashboardHeader(
  title = title, titleWidth = 300
)



sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(
     text = "Global Ratio",
     tabName = "global_ratio",
     icon = icon("chart-bar")
      )
    )
  )


body <- dashboardBody(
  tabItems(
    tabItem(tabName = "global_ratio",
        fluidRow(
        column(width = 3,
          box(width = NULL,
              title = "Select Rating:",
         selectInput(
           inputId = "ratingOpt",
           label = " ",
           choices = rating_unique,
           multiple = FALSE
            )
          )
        ),
        column(width = 9,
               box(width = NULL,
                   title = "Global Ratio based on Genre",
                   plotlyOutput("ratingPlot")
               )
        ),
        column(width = 3,
               box(width = NULL,
                   title = "Select rating:",
                   selectInput(
                     inputId = "densityOpt",
                     label = " ",
                     choices = rating_unique,
                     multiple = FALSE
                   )
               )
        ),
        column(width = 9,
               box(width = NULL,
                   title = "Genre density based on rating",
                   plotOutput("densityPlot")
                     )
                   )
                 )
               )
             )
           )

dashboardPage(
  skin = "red",
  header = header,
  body = body, 
  sidebar = sidebar
)