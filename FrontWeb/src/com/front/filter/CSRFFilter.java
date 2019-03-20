package com.front.filter;

import java.io.IOException;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

@WebFilter(filterName="filter1", urlPatterns="/*")
public class CSRFFilter implements Filter {
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		
		
		// Get client's origin
        String clientOrigin = ((HttpServletRequest)request).getHeader("Origin");
        System.out.println("Inside filter one. getRequestURI="+((HttpServletRequest)request).getRequestURI());
        System.out.println("Inside filter one. clientOrigin="+clientOrigin);
        
		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {
	}
}