package com.example.demo.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

	@Value("${custom.genFileDirPath}")
	private String genFileDirPath;

	// CORS 허용 (타 사이트에서 나의 DB호출 허용)
	@Override
	public void addCorsMappings(CorsRegistry registry) {
		registry.addMapping("/**");
	}

	// beforeActionInterceptor 인터셉터 불러오기
	@Autowired
	@Qualifier("beforeActionInterceptor")
	HandlerInterceptor beforeActionInterceptor;

	// needLoginInterceptor 인터셉터 불러오기	
	@Autowired
	@Qualifier("needAdminInterceptor")
	HandlerInterceptor needAdminInterceptor;

	// needLoginInterceptor 인터셉터 불러오기
	@Autowired
	@Qualifier("needLoginInterceptor")
	HandlerInterceptor needLoginInterceptor;

	// needToLogoutInterceptor 인터셉터 불러오기
	@Autowired
	@Qualifier("needToLogoutInterceptor")
	HandlerInterceptor needToLogoutInterceptor;

	// 이 함수는 인터셉터를 적용하는 역할을 합니다.
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// beforeActionInterceptor 인터셉터가 모든 액션 실행전에 실행되도록 처리
		registry.addInterceptor(beforeActionInterceptor).addPathPatterns("/**").excludePathPatterns("/resource/**")
				.excludePathPatterns("/gen/**");

		// 관리자 로그인 없이도 접속할 수 있는 URI 기술
		registry.addInterceptor(needAdminInterceptor).addPathPatterns("/adm/**")
				.excludePathPatterns("/adm/member/login").excludePathPatterns("/adm/member/doLogin")
				.excludePathPatterns("/adm/member/loginTest").excludePathPatterns("/adm/member/doLoginTest")
				.excludePathPatterns("/adm/member/signup").excludePathPatterns("/adm/member/doSignup")
				.excludePathPatterns("/adm/member/getLoginIdDup").excludePathPatterns("/adm/member/getNicknameDup")
				.excludePathPatterns("/adm/member/getPWDup").excludePathPatterns("/adm/member/getPhoneNoDup")
				.excludePathPatterns("/adm/member/getEmailDup").excludePathPatterns("/adm/article/test");

		// 로그인 없이도 접속할 수 있는 URI 기술
		registry.addInterceptor(needLoginInterceptor).addPathPatterns("/usr/**").excludePathPatterns("/")
				.excludePathPatterns("/swagger-ui/**").excludePathPatterns("/swagger-resources/**")
				.excludePathPatterns("/v2/api-docs").excludePathPatterns("/webjars/**")
				.excludePathPatterns("/common/**").excludePathPatterns("/error")
				.excludePathPatterns("/usr/home/*")
				// 게시물
				.excludePathPatterns("/usr/article/list").excludePathPatterns("/usr/article/detail")
				.excludePathPatterns("/usr/article/showDetail")
				// 회원
				.excludePathPatterns("/usr/member/signup").excludePathPatterns("/usr/member/doSignup")
				.excludePathPatterns("/usr/member/login").excludePathPatterns("/usr/member/doLogin")
				.excludePathPatterns("/usr/member/findID").excludePathPatterns("/usr/member/doFindID")
				.excludePathPatterns("/usr/member/findPW").excludePathPatterns("/usr/member/doFindPW")
				.excludePathPatterns("/usr/member/getLoginIdDup").excludePathPatterns("/usr/member/getNicknameDup")
				.excludePathPatterns("/usr/member/getPWDup").excludePathPatterns("/usr/member/getPhoneNoDup")
				.excludePathPatterns("/usr/member/getEmailDup").excludePathPatterns("/usr/member/authKey");

		// 로그인 상태에서 접속할 수 없는 URI 전부 기술(로그아웃 상태에서 접속할 수 잇는 URI)
		registry.addInterceptor(needToLogoutInterceptor)
				.addPathPatterns("/usr/member/login").addPathPatterns("/usr/member/doLogin")
				.addPathPatterns("/usr/member/signup").addPathPatterns("/usr/member/doSignup")
				.addPathPatterns("/usr/member/findID").addPathPatterns("/usr/member/doFindID")
				.addPathPatterns("/usr/member/findPW").addPathPatterns("/usr/member/doFindPW");
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/gen/**").addResourceLocations("file:///" + genFileDirPath + "/")
				.setCachePeriod(20);
	}
}
