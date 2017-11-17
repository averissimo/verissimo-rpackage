#' Title
#'
#' @param base.dir
#' @param fun
#' @param ...
#' @param cache.prefix
#' @param force.recalc
#'
#' @return
#' @export
#'
#' @examples
setGeneric("runCache", function(base.dir, fun, ..., cache.prefix = 'generic_cache', force.recalc = FALSE) {
  cat('Wrong arguments, first argument must be a path and second a function!\n')
  cat('  Usage: run(tmpBaseDir, functionName, 1, 2, 3, 4, 5)\n')
  cat('  Usage: run(tmpBaseDir, functionName, 1, 2, 3, 4, 5, cache.prefix = \'someFileName\', force.recalc = TRUE)\n')
})

setMethod('runCache', signature('character', 'function'), function(base.dir, fun, ..., cache.prefix = 'generic_cache', force.recalc = FALSE) {
  args <- list(...)
  path <- file.path(base.dir, sprintf('%s-H_%s.RData', cache.prefix, digest::sha1(args)))
  if (file.exists(path) && !force.recalc) {
    cat(sprintf('Loading from cache (not calculating): %s\n', path))
    load(path)
  } else {
    result <- fun(...)
    save(result, file = path)
  }
  return(result)
})