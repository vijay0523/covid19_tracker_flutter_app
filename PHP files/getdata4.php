<?php
require 'simple_html_dom.php';

$html = file_get_html('https://www.mohfw.gov.in/');
$rcases = $html->find('strong', 8);
echo $rcases->plaintext;
echo json_decode($rcases);
?>