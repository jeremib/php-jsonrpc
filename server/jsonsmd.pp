<?
/**
 * JSON-RPC Server
 * 
 * SMD Generation script
 * Based off of http://www.stubbles.net/wiki/Docs/JsonRpc
 * 
 * @author Jeremi Bergman <jeremi@jeremibergman.com>
 * 
 */

$class_name = $_GET['class'];

if ( file_exists("services/{$class_name}.php") ) {
	require "services/{$class_name}.php";	
} else {
	echo json_encode(array('error' => 'Classname does not exist'));
	exit;
}


$class = new ReflectionClass($class_name);

$smd_data = new stdClass();
$smd_data->smdVersion = 1;
$smd_data->serviceType = 'JSON-RPC';
$smd_data->serviceURL = './server.php';

$smd_data->objectName = $class_name;
$smd_data->methods = array();

foreach ($class->getMethods() as $method) {
	if (!$method->isPublic()) {
		continue;
	}
	$method_def = new stdClass();
	$method_def->name = $method->getName();
	$method_def->parameters = array();
	foreach ($method->getParameters() as $parameter) {
		$param_def = new stdClass();
		$param_def->name = $parameter->getName();
		$method_def->parameters[] = $param_def;
	}
	$smd_data->methods[] = $method_def;
}
echo json_encode($smd_data);

 ?>
