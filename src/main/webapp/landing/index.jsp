<%@ page language="java" contentType="text/html; charset=UTF-8" session="false" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="baseURL" value='<%= System.getenv("CANFAR_WEB_HOST") %>' />

<!-- Default to current host. -->
<c:if test="${empty baseURL}">
    <c:set var="req" value="${pageContext.request}" />
    <c:set var="url">${req.requestURL}</c:set>
    <c:set var="uri" value="${req.requestURI}" />
    <c:set var="baseURL" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}" />
</c:if>

<c:set var="resourceCapabilitiesEndPoint" value="${baseURL}/reg/resource-caps" />
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/" />

    <c:import url="${baseURL}/canfar/includes/_page_top_styles.shtml" />
    <link rel="stylesheet" type="text/css"
          href="<c:out value=" ${baseURL}/citation/css/datatables.css " />" media="screen"
    />
    <link rel="stylesheet" type="text/css"
          href="<c:out value=" ${baseURL}/citation/css/citation.css " />" media="screen"
    />
    <link rel="stylesheet" type="text/css"
          href="<c:out value=" ${baseURL}/cadcVOTV/css/jquery-ui-1.11.4.min.css " />" media="screen"
    />

    <!-- Located in ROOT.war -->
    <script type="application/javascript" src="${baseURL}/canfar/javascript/jquery-2.2.4.min.js"></script>
    <script type="application/javascript" src="${baseURL}/canfar/javascript/bootstrap.min.js"></script>

    <!--[if lt IE 9]>
    <script src="/html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <title>Data Publication</title>
</head>

<body>
<c:import url="${baseURL}/canfar/includes/_application_header.shtml" />
<div class="container-fluid fill">
    <div class="row fill">
        <div role="main" class="col-sm-12 col-md-12 main fill">
            <div class="inner fill">
                <section id="main_content" class="fill">

                    <h3 class="doi-page-header">
                        <a id="canfar-doi" class="anchor" href="#canfar-doi" aria-hidden="true">
                            <span aria-hidden="true" class="octicon octicon-link"></span>
                        </a>Data Publication
                    </h3>

                    <div >
                        <div class="panel panel-default doi-panel">
                            <div class="panel-heading doi-panel-heading">
                                <h4>Digital Object Identifier (DOI) Information</h4>
                            </div>
                            <div class="progress doi-progress-bar-container">
                                <div class="progress-bar progress-bar-success doi-progress-bar"
                                     role="progressbar" aria-valuenow="100" aria-valuemin="100" aria-valuemax="100">
                                </div>
                            </div>

                            <div class="panel-body doi-panel-body">

                                <div class="doi-not-authenticated hidden"><button type="submit" class="btn btn-primary" id="doi_login_button">
                                    <i>Login Required...</i></button>
                                </div>

                                <div class="doi-authenticated">
                                    <!-- Noficiation and Alert bars -->
                                    <div class="alert alert-danger hidden">
                                        <strong id="status_code">444</strong>&nbsp;&nbsp;<span id="error_msg">Server error</span>
                                    </div>

                                    <div class="alert alert-success hidden">
                                        <span id="alert_msg"></span>
                                    </div>

                                    <!-- Display starts -->

                                    <div class="container">
                                        <!-- Data DOI Number -->
                                        <div class="row">
                                            <label for="doi_number" class="doi-landing text-right col-sm-3 control-label">
                                                Data DOI Reference
                                            </label>
                                            <div id="doi_number" class="col-sm-3 doi-landing doi-landing-text"></div>
                                        </div>


                                        <!-- Publication Title -->
                                        <div class="row">
                                            <label for="doi_title" class="col-sm-3 doi-landing text-right control-label">
                                                Publication Title
                                            </label>
                                            <div id="doi_title" class="col-sm-8 doi-landing doi-landing-text"></div>
                                        </div>

                                        <!-- Publication DOI   -->
                                        <!-- todo: consider hiding this if not present -->
                                        <div class="row">
                                            <label for="publication_doi" class="col-sm-3 doi-landing text-right control-label">
                                                Publication DOI
                                            </label>
                                            <div id="publication_doi" class="col-sm-3 doi-landing doi-landing-text"></div>
                                        </div>

                                        <!-- Author List -->
                                        <div class="row">
                                            <label for="doi_number" class="col-sm-3 doi-landing text-right  control-label">
                                                Authors
                                            </label>
                                            <div id="doi_creator_list" class="col-sm-4 doi-landing doi-landing-text"></div>
                                        </div>

                                        <!-- Journal Reference -->
                                        <div class="doi-journal-ref row">
                                            <label for="doi_number" class="col-sm-3 doi-landing text-right control-label">
                                                Journal Reference
                                            </label>
                                            <div id="doi_journal_ref" class="col-sm-6 doi-landing doi-landing-text"><i>not available</i></div>
                                        </div>

                                        <!-- Status   -->
                                        <div class="row">
                                            <label for="doi_number" class="col-sm-3 doi-landing text-right control-label">
                                                DOI Status
                                            </label>
                                            <div id="doi_status" class="col-sm-3 doi-landing doi-landing-text"></div>
                                        </div>

                                        <!-- Data Directory -->
                                        <div class="row">
                                            <label for="doi_number" class="col-sm-3 doi-landing text-right control-label">
                                                Data Directory
                                            </label>
                                            <div id="doi_data_dir" class="col-sm-6 doi-landing doi-landing-text"></div>
                                        </div>


                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <!-- Info Modal -->
                    <div class="modal fade" id="info_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="infoModalLongTitle"></h5>
                                </div>
                                <div class="modal-body">
                                    <span class="info-span"></span>
                                    <span class="spinner-span glyphicon glyphicon-refresh fast-right-spinner"></span>
                                </div>
                                <div id="infoThanks" class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Thanks</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Content ends -->
                </section>
            </div>
        </div>
    </div>
</div>

<script type="application/javascript" src="<c:out value=" ${baseURL}/canfar/javascript/cadc.contexthelp.js" />"></script>
<script type="application/javascript" src="<c:out value=" ${baseURL}/citation/js/citation_page.js" />"></script>
<script type="application/javascript" src="<c:out value=" ${baseURL}/citation/js/citation_landing.js" />"></script>

<script type="application/javascript">
  $(document).ready(function() {

    // Set up  controller for Data Citation List page
    landing_page = new cadc.web.citation.CitationLanding({baseURL: window.location.origin})
    landing_page.init()

  });

</script>

</body>

</html>


