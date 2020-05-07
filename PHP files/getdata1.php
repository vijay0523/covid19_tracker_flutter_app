<?php
require 'simple_html_dom.php';

$html = file_get_html('https://www.mohfw.gov.in/');
$acases = $html->find('strong', 6);
echo $acases->plaintext;
echo json_decode($acases);
?>