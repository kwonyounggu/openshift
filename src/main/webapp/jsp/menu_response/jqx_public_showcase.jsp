<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.*" %>
<%@ page isELIgnored ="false" %>

<div id="sickkidsCarousel" class="carousel slide" data-ride="carousel">
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#sickkidsCarousel" data-slide-to="0" class="active"></li>
    <li data-target="#sickkidsCarousel" data-slide-to="1"></li>
    <li data-target="#sickkidsCarousel" data-slide-to="2"></li>
    <li data-target="#sickkidsCarousel" data-slide-to="3"></li>
    <li data-target="#sickkidsCarousel" data-slide-to="4"></li>
    <li data-target="#sickkidsCarousel" data-slide-to="5"></li>
  </ol>

  <!-- Wrapper for slides -->
  <div class="carousel-inner" role="listbox">
    <div class="item active">
      <img src="images/freelance_showcase/carm_vital_signs.PNG" alt="SickKids">
    </div>

    <div class="item">
      <img src="images/freelance_showcase/carm_login.PNG" alt="SickKids">
    </div>

    <div class="item">
      <img src="images/freelance_showcase/carm_labdata_result.PNG" alt="SickKids">
    </div>

    <div class="item">
      <img src="images/freelance_showcase/carm_diagnotics_problems.PNG" alt="SickKids">
    </div>
    <div class="item">
      <img src="images/freelance_showcase/carm_data_review.PNG" alt="SickKids">
    </div>
    <div class="item">
      <img src="images/freelance_showcase/carm_admin.PNG" alt="SickKids">
    </div>
  </div>

  <!-- Left and right controls -->
  <a class="left carousel-control" href="#sickkidsCarousel" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#sickkidsCarousel" role="button" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>