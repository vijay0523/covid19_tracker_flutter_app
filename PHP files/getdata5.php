<?php
require 'simple_html_dom.php';

$html = file_get_html('https://www.mohfw.gov.in/');
foreach($html->find('table tr td') as $e){
    $arr[] = trim($e->plaintext);
  }
//print_r($arr);
echo json_encode($arr);
?>