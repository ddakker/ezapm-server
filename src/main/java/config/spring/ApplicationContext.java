package config.spring;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;

@ImportResource("classpath:config/spring/context-*.xml")
@Configuration
public class ApplicationContext {
	
	
}
