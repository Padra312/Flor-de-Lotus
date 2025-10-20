package com.project.site.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;


@Configuration
public class WebConfig implements WebMvcConfigurer {
	// ==========================================================
	// MÉTODO: Configurar Interceptadores
	// ==========================================================
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// registry: Registro central de interceptadores do Spring MVC
		// Adiciona o AuthInterceptor ao registro de interceptadores
		registry.addInterceptor(new AuthInterceptor())
				// .addPathPatterns(): Define quais URLs serão interceptadas
				// "/products/**": Todas as URLs que começam com /products
				// "/users/**": Todas as URLs que começam com /users
				// ** significa "qualquer subcaminho"
				.addPathPatterns("/categories/**", "/users/**","/massagens/**")
				// .excludePathPatterns(): Define URLs que NÃO serão interceptadas
				// "/login": Página de login (deve ser acessível sem autenticação)
				// "/css/**": Arquivos CSS (recursos estáticos)
				// "/js/**": Arquivos JavaScript (recursos estáticos)
				.excludePathPatterns("/","/login","/users/register", "/css/**", "/js/**","images/**"); 	}
	
	@Override
	public void addCorsMappings(CorsRegistry registry) {
	    registry.addMapping("/**")
	            .allowedOriginPatterns("*")
	            .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
	            .allowedHeaders("*")
	            .allowCredentials(true);
	}
	
	// Configuração para servir arquivos estáticos
	   @Override
	   public void addResourceHandlers(ResourceHandlerRegistry registry) {
	       registry.addResourceHandler("/imagens/**")
	               .addResourceLocations("classpath:/static/imagens/");
	   }
}
