<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/community-nav.css">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/community-header.css">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/community-ranking-and-postlist.css">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/community-posting.css">
<script src="https://cdn.ckeditor.com/ckeditor5/39.0.2/super-build/ckeditor.js"></script>

<!-- #게시물 선택 바 시작-->


<form method="post" action="${pageContext.servletContext.contextPath}/FreeCommunity/writeOk"
      style="margin: 0 auto; width: 1000px">
    <input type="text" name="subject" placeholder="제목" style="margin-top: 30px; height: 30px; width: 300px"/>
    <hr/>
    <div class="body-select" style="margin-top: 10px; margin-bottom: 10px;">
        <b>주요부위</b> &nbsp; &nbsp;
        상체 : <input type="radio" name="first-part" value="upper"/>
        하체 : <input type="radio" name="first-part" value="lower"/>
        <hr style="margin-top: 10px"/>
        가슴 : <input type="checkbox" name="body-part" value="chest">
        어깨 : <input type="checkbox" name="body-part" value="shoulder">
        등 : <input type="checkbox" name="body-part" value="back">
        팔 : <input type="checkbox" name="body-part" value="arm">
        복부 : <input type="checkbox" name="body-part" value="stomach">
        허리 : <input type="checkbox" name="body-part" value="waist">
        <br/>
        허벅지 : <input type="checkbox" name="body-part" value="thigh">
        엉덩이 : <input type="checkbox" name="body-part" value="hip">
        종아리 : <input type="checkbox" name="body-part" value="calf">
    </div>
    <textarea id="ckEditor" name="content"></textarea>
    <div class="write">
        <button id="writeButton" type="button">작성</button>
    </div>
</form>

<script>
    var form = document.querySelector('form');
    CKEDITOR.ClassicEditor.create(document.getElementById("ckEditor"), {
            toolbar: {
                items: [
                    'exportPDF', 'exportWord', '|',
                    'findAndReplace', 'selectAll', '|',
                    'heading', '|',
                    'bold', 'italic', 'strikethrough', 'underline', 'code', 'subscript', 'superscript', 'removeFormat', '|',
                    'bulletedList', 'numberedList', 'todoList', '|',
                    'outdent', 'indent', '|',
                    'undo', 'redo',
                    '-',
                    'fontSize', 'fontFamily', 'fontColor', 'fontBackgroundColor', 'highlight', '|',
                    'alignment', '|',
                    'link', 'insertImage', 'blockQuote', 'insertTable', 'mediaEmbed', 'codeBlock', 'htmlEmbed', '|',
                    'specialCharacters', 'horizontalLine', 'pageBreak', '|',
                    'textPartLanguage', '|',
                    'sourceEditing'
                ],
                shouldNotGroupWhenFull: true
            },
            list: {
                properties: {
                    styles: true,
                    startIndex: true,
                    reversed: true
                }
            },
            heading: {
                options: [
                    {model: 'paragraph', title: 'Paragraph', class: 'ck-heading_paragraph'},
                    {model: 'heading1', view: 'h1', title: 'Heading 1', class: 'ck-heading_heading1'},
                    {model: 'heading2', view: 'h2', title: 'Heading 2', class: 'ck-heading_heading2'},
                    {model: 'heading3', view: 'h3', title: 'Heading 3', class: 'ck-heading_heading3'},
                    {model: 'heading4', view: 'h4', title: 'Heading 4', class: 'ck-heading_heading4'},
                    {model: 'heading5', view: 'h5', title: 'Heading 5', class: 'ck-heading_heading5'},
                    {model: 'heading6', view: 'h6', title: 'Heading 6', class: 'ck-heading_heading6'}
                ]
            },
            placeholder: '내용을 입력해주세요.',
            fontFamily: {
                options: [
                    'default',
                    'Arial, Helvetica, sans-serif',
                    'Courier New, Courier, monospace',
                    'Georgia, serif',
                    'Lucida Sans Unicode, Lucida Grande, sans-serif',
                    'Tahoma, Geneva, sans-serif',
                    'Times New Roman, Times, serif',
                    'Trebuchet MS, Helvetica, sans-serif',
                    'Verdana, Geneva, sans-serif'
                ],
                supportAllValues: true
            },
            fontSize: {
                options: [10, 12, 14, 'default', 18, 20, 22],
                supportAllValues: true
            },
            htmlSupport: {
                allow: [
                    {
                        name: /.*/,
                        attributes: true,
                        classes: true,
                        styles: true
                    }
                ]
            },
            htmlEmbed: {
                showPreviews: true
            },
            link: {
                decorators: {
                    addTargetToExternalLinks: true,
                    defaultProtocol: 'https://',
                    toggleDownloadable: {
                        mode: 'manual',
                        label: 'Downloadable',
                        attributes: {
                            download: 'file'
                        }
                    }
                }
            },
            mention: {
                feeds: [
                    {
                        marker: '@',
                        feed: [
                            '@apple', '@bears', '@brownie', '@cake', '@cake', '@candy', '@canes', '@chocolate', '@cookie', '@cotton', '@cream',
                            '@cupcake', '@danish', '@donut', '@dragée', '@fruitcake', '@gingerbread', '@gummi', '@ice', '@jelly-o',
                            '@liquorice', '@macaroon', '@marzipan', '@oat', '@pie', '@plum', '@pudding', '@sesame', '@snaps', '@soufflé',
                            '@sugar', '@sweet', '@topping', '@wafer'
                        ],
                        minimumCharacters: 1
                    }
                ]
            },
            removePlugins: [
                'CKBox',
                'CKFinder',
                'EasyImage',
                'RealTimeCollaborativeComments',
                'RealTimeCollaborativeTrackChanges',
                'RealTimeCollaborativeRevisionHistory',
                'PresenceList',
                'Comments',
                'TrackChanges',
                'TrackChangesData',
                'RevisionHistory',
                'Pagination',
                'WProofreader',
                'MathType',
                'SlashCommand',
                'Template',
                'DocumentOutline',
                'FormatPainter',
                'TableOfContents',
                'PasteFromOfficeEnhanced'
            ]
        }
    ).then(editor => {
        window.editor = editor;

        document.getElementById("writeButton").addEventListener("click", function (event) {
            var subject = document.querySelector('input[name="subject"]').value;
            var content = editor.getData();

            if (!subject || !content) {
                alert("제목과 내용을 입력해주세요!");
            } else {
                // 모든 조건이 충족되었으므로 폼 제출
                form.submit();
            }
        });
    })
        .catch(err => {
            console.error(err.stack);
        });


</script>
<!-- ck에디터 폼 끝 -->


<script src="${pageContext.servletContext.contextPath}/js/community-default.js"></script>
<script src="${pageContext.servletContext.contextPath}/js/community-post-paging.js"></script>

