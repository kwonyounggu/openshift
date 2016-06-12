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
  </ol>

  <!-- Wrapper for slides -->
  <div class="carousel-inner" role="listbox">
    <div class="item active">
      <img src="img_chania.jpg" alt="Chania">
    </div>

    <div class="item">
      <img src="img_chania2.jpg" alt="Chania">
    </div>

    <div class="item">
      <img src="img_flower.jpg" alt="Flower">
    </div>

    <div class="item">
      <img src="img_flower2.jpg" alt="Flower">
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