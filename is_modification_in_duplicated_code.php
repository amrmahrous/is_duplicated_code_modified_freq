<?php
/*
count the modicication for duplicated and none duplicated
You will need to change the csv file name for the modification , and must a database table with the duplicated code
Author : Amr Mahrous
*/

$start = microtime(TRUE);
echo $start . "//// \n";

$servername = "localhost";
$username = "root";
$password = "root";

$conn = mysqli_connect($servername, $username, $password,'duplicated_code');

if (! $conn) {
    die("Connection failed: " . mysqli_connect_error());
}

$filename = 'csv/qmailadmin_modifications.csv';

$row = 1;
$duplicate = 0;
$nonDuplicate = 0;
$dup = 0;
$non = 0;
$r = [];

$lines = file($filename);
$i = 0;
$rowCount = count($lines);
$reminder = intval($rowCount / 10);
foreach ($lines as $line_num => $row) {
    if ($i != 0 && $i % $reminder == 0) {
        $r[] = [
            'dup' => $dup,
            'non' => $non
        ];
        $dup = 0;
        $non = 0;
        $end = microtime(TRUE);
        echo "The code took  ( " . ($end - $start) . " ) seconds to complete.";
        echo $end, "\n";
        echo "duplicate=" . $duplicate . ";;", "\n";
        echo "nonDuplicate = " . $nonDuplicate . ";;", "\n";
        echo "result === " . print_r($r) . ";;", "\n";
    }

    $data = explode(';', $row);

    $project = $data[0];
    $commit = $data[1];
    $file = $data[2];
    
    $start_delete = intval($data[3]);
    $deleted_lines = intval($data[4]);
    $end_delete = $start_delete + $deleted_lines;
    $start_add = intval($data[5]);
    $add_lines = intval($data[6]);
    $end_add = $start_add + $add_lines;

    $sql = "SELECT * FROM pmd_cpd WHERE (project = '$project' and commit= '$commit' and file= '$file') and
        ( ( start_line >= $start_add and end_line <= $start_add ) or 
          ( start_line >= $start_delete and start_line <= $end_delete) or 
          ( end_line <= $end_delete and end_line >= $start_delete ) ) limit 1";

    $result = mysqli_query($conn, $sql);    
    $i ++;
    if (mysqli_num_rows($result) > 0) {
        $duplicate ++;
        $dup++;
        while($row = mysqli_fetch_assoc($result)) {
            if ($row['end_line'] > $end_add || $row['start_line'] < $start_add) {
                $nonDuplicate ++;
                $non++;
            }
        }
    } else {
        $nonDuplicate++;
        $non++;
       continue;
    }
    $i ++;
}
mysqli_close($conn);
echo "duplicate === " . $duplicate . "--<br>";
echo "nonDuplicate === " . $nonDuplicate . "--<br>";
echo "result === " . print_r($r) . "--<br>";

?>
