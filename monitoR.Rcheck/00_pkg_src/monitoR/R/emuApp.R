utils::globalVariables(
  c("skink", ".data")
)
emuApp <- function(){
  
  # data(skink)
  ui <- shiny::fluidPage(
    
    shiny::titlePanel("MonitoR shiny app"),
    
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        shiny::fileInput("zoo_file", "Upload zoo monitor data"),
        shiny::hr(),
        shiny::sliderInput("grid_x", "Grid cols",
        min = 1, max = 10, value = 4),
        shiny::sliderInput("grid_y", "Grid rows",
        min = 1, max = 10, value = 4),
        shiny::hr(),
        shiny::checkboxGroupInput(
          "behaviour",
          "Choose behaviours to show",
          choices = unique(skink$behaviour),
          selected = unique(skink$behaviour)
        ),
        shiny::hr(),
        shiny::sliderInput("n_zones", "Number of zones",
        min = 1, max = 5, value = 2),
        shiny::checkboxInput("zone", "Show zones"),
        shiny::checkboxInput("grid", "Colour points by grid"),
      ),
      
      shiny::mainPanel(
        shiny::tabsetPanel(
          shiny::tabPanel(
            "Grid plot",
            shiny::plotOutput("grid_plot", height = "800px", click = "plot_click")
          ),
          shiny::tabPanel(
            "Diversity measures",
            shiny::h1("Entropy - base 10"),
            shiny::plotOutput("entropy_plot"),
            shiny::h1("Modified SPI"),
            shiny::plotOutput("spi_plot"),
            shiny::h1("Elective index"),
            shiny::plotOutput("ei_plot")
          ),
          shiny::tabPanel(
            "Summary statistics",
            shiny::plotOutput("summary_plot")
          ),
          shiny::tabPanel(
            "Debugging",
            shiny::verbatimTextOutput(outputId = "debug")
          )
        )
      )
    )
  )
  
  # SERVER ----
  server <- function(input, output, session) {
    ## UI ----
    shiny::observeEvent(input$zoo_file, {
      shiny::updateCheckboxGroupInput(
        inputId = "behaviour",
        choices = unique(zoo()$behaviour),
        selected = unique(zoo()$behaviour))
      })
      ## PLOTS ----
      output$grid_plot <- shiny::renderPlot({
        plot_grid(grid$df, zoo_grid_filter(), input$grid, input$zone)
      })
      output$entropy_plot <- shiny::renderPlot({
        plot_entropy(zoo_grid_filter())
      })
      output$spi_plot <- shiny::renderPlot({
        shiny::validate(
          shiny::need(
            length(unique(grid$df$zone)) > 1,
            'Need at least two zones'
          )
        )
        plot_spi(grid$df, zoo_grid_filter())
      })
      output$ei_plot <- shiny::renderPlot({
        shiny::validate(
          shiny::need(
            length(unique(grid$df$zone)) > 1,
            'Best with at least two zones'
          )
        )
        plot_ei(grid$df, zoo_grid_filter())
      })
      output$summary_plot <- shiny::renderPlot({
        plot_summary(zoo_grid_filter())
      })
      ## DATA ----
      grid <- shiny::reactiveValues(df=NULL)
      shiny::observe({
        df <- create_grid(
          range(zoo()$X),
          range(zoo()$Y),
          dim = c(input$grid_x,input$grid_y)
        )
        grid$df <- df
      })
      shiny::observeEvent(input$plot_click, {
        df <- update_zone(grid$df,
          input$plot_click$x,
          input$plot_click$y,
          input$n_zones)
          print(df)
          grid$df <- df
        }
      )
      file_zoo <- shiny::reactive({
        shiny::req(input$zoo_file)
        ext <- tools::file_ext(input$zoo_file$name)
        switch(ext,
          xlsx = read_zoo(input$zoo_file$datapath),
          shiny::validate("Invalid file; Please upload a .xlsx file")
        )
      })
      zoo <- shiny::reactive({
        tryCatch({
          file_zoo()
        },
        shiny.silent.error = function(e) {
          skink
        }
      )
    })
    zoo_grid <- shiny::reactive({
      add_grid(zoo(), grid$df)
    })
    zoo_grid_filter <- shiny::reactive({
      zoo_grid() |>
      dplyr::filter(.data$behaviour %in% input$behaviour)
    })
    # DEBUG ----
    output$debug <- shiny::renderPrint({
      print(stringr::str_glue("input$zone: {input$zone}"))
      print(stringr::str_glue("input$grid: {input$grid}"))
      print(stringr::str_glue("input$n_zones: {input$n_zones}"))
      cat("grid\n")
      print(grid$df)
      cat("Plot click\n")
      print(input$plot_click$x)
      cat("zoo_grid()\n")
      print(length(unique(grid$df$zone)))
    })
  }
  
  # DRIVER ----
  shiny::shinyApp(ui = ui, server = server)
  
}
# pacman::p_load(conflicted, tidyverse, targets)
# emuApp()
