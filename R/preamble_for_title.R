#' Preamble for Title Page
#'
#' Creates the preamble.tex file for the title page to work
#'
#'
#' @param covertitle covertitle 
#' @param abstracttitle abstracttitle 
#' @param author author 
#' @param department department 
#' @param narrowdepartment narrowdepartment 
#' @param degreetype degreetype 
#' @param degreemonth degreemonth 
#' @param degreeyear degreeyear 
#' @param chair chair 
#' @param committee committee 
#' @param graddean graddean 
#' @param abstract_tex abstract_tex 
#' @param cv_tex cv_tex 
#' @param acknowledge_tex acknowledge_tex 
#' @param dedication_tex dedication_tex 
#' @param preamble_template_tex preamble_template_tex
#' @param preamble_tex preamble_tex
#'
#' @import rmarkdown
#' @import knitr
#' @import readr
#' @export
preamble_for_title = function(
  covertitle, abstracttitle, author, department, narrowdepartment, 
  degreetype, degreemonth, degreeyear, chair, committee, graddean, 
  abstract_tex = NULL, cv_tex = NULL, acknowledge_tex = NULL, dedication_tex = NULL, 
  preamble_template_tex = "0_uothesisapa_preamble.tex", preamble_tex = "preamble.tex"){
  
  #These commands are defined in the documentclass
cover <- paste0(
'\\covertitle{', covertitle, '}
\\abstracttitle{', abstracttitle, '}
\\author{', author, '}
\\department{', department, '}
\\narrowdepartment{', narrowdepartment, '}
\\degreetype{', degreetype, '}
\\degreemonth{', degreemonth, '}
\\degreeyear{', degreeyear, '}
\\chair{', chair, '}
\\committee{', committee, '}
\\graddean{', graddean, '}')

if(!is.null(abstract_tex) && file.exists(abstract_tex)){
  abstract <- paste0('\\abstract{\n',
                     readr::read_file(abstract_tex),
                     '\n}')
} else if(!is.null(abstract_tex)){
  #assume it's text
  abstract <- paste0('\\abstract{\n',
                     abstract_tex,
                     '\n}')
} else {
  abstract <- ''
}

if(!is.null(cv_tex) && file.exists(cv_tex)){
  cv <- readr::read_file(cv_tex)
} else if(!is.null(cv_tex)){
  #assume it's text
  cv <- cv_tex
} else {
  cv <- ''
}

if(!is.null(acknowledge_tex) && file.exists(acknowledge_tex)){
  acknowledge <- paste0('\\acknowledge{\n',
                     readr::read_file(acknowledge_tex),
                     '\n}')
} else if(!is.null(acknowledge_tex)){
  #assume it's text
  acknowledge <- paste0('\\acknowledge{\n',
                     acknowledge_tex,
                     '\n}')
} else {
  acknowledge <- ''
}

if(!is.null(dedication_tex) && file.exists(dedication_tex)){
  dedication <- paste0('\\dedication{\n',
                        readr::read_file(dedication_tex),
                        '\n}')
} else if(!is.null(dedication_tex)){
  #assume it's text
  dedication <- paste0('\\dedication{\n',
                       dedication_tex,
                        '\n}')
} else {
  dedication <- ''
}   

full_preamble <- paste(readr::read_file(preamble_template_tex),
                       cover, abstract, cv, 
                       acknowledge, dedication, 
                       sep = '\n')
readr::write_file(full_preamble, path = preamble_tex)
}
