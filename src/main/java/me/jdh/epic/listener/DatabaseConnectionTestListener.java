package me.jdh.epic.listener;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * 애플리케이션 시작 시 데이터베이스 연결을 테스트하는 리스너
 * - Spring Context가 로드된 후 JdbcTemplate을 사용하여 간단한 쿼리를 실행함
 * - 연결 성공/실패 상태를 로그로 출력함
 */
public class DatabaseConnectionTestListener implements ServletContextListener {

  @Override
  public void contextInitialized(ServletContextEvent sce) {
    System.out.println("[DB Connection Test] Starting...");

    try {
      // Get Spring WebApplicationContext
      WebApplicationContext context = WebApplicationContextUtils
          .getRequiredWebApplicationContext(sce.getServletContext());

      // Get JdbcTemplate Bean
      JdbcTemplate jdbcTemplate = context.getBean("jdbcTemplate", JdbcTemplate.class);

      // PostgreSQL uses "SELECT 1"
      Integer result = jdbcTemplate.queryForObject("SELECT 1", Integer.class);

      System.out.println("[DB Connection Test] Success! Query result: " + result);
      System.out.println("[DB Connection Test] Database connection is working properly.");

    } catch (Exception e) {
      System.err.println("[DB Connection Test] Failed!");
      System.err.println("[DB Connection Test] Error message: " + e.getMessage());
      e.printStackTrace();
    }
  }

  @Override
  public void contextDestroyed(ServletContextEvent sce) {
    System.out.println("[DB Connection Test] Application shutdown");
  }
}