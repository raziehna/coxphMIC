#' Compute the penalized log partial likelihood for a Cox PH model with MIC penalty
#'
#' @param beta A p-dimensional vector containing the regression ceofficients in the CoxPH model.
#' @param time The observed survival time.
#' @param status The status indicator: 1 for event and 0 for censoring.
#' @param X An \eqn{n} by \eqn{p} design matrix.
#' @param lambda The penalty parameter euqals either 2 in AIC or ln(n0) in BIC (by default), where n0 is the number
#' of uncensored survival times observed in the data. You can also specify it to a specific value of your own choice.
#' @param a The scale parameter in the hyperbolic tangent function of the MIC penalty. By default, \eqn{a = n0}, i.e., the number
#' of uncensored survival times observed in the data.
#' @return The value of the penalized log partial likelihood function evaluated at beta.
#' @seealso \code{\link{coxph}}
#' @references Su, X., Wijayasinghe, C. S., Fan, J., and Zhang, Y. (2015). Sparse estimation of Cox proportional hazards models via approximated information criteria. \emph{Biometrics}. \url{http://onlinelibrary.wiley.com/doi/10.1111/biom.12484/epdf}

LoglikPen <- function(beta, time, status, X, lambda, a)
{
	# THE PENALTY PART
	w <- tanh(a*beta^2)
	beta.prime <- beta*w
	eta <- X%*%beta.prime
	# LOG-LIKELIHOOD
	L <- sum(status*(eta-log(cumsum(exp(eta)))))
	# THE OBJECTIVE FUNCTION
	L.pen <- - 2*L + lambda*sum(w)
	return(L.pen)
}
