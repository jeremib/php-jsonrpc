<?

/**
 * JSON-RPC Server
 * 
 * Based off of http://www.stubbles.net/wiki/Docs/JsonRpc
 * 
 * @author Jeremi Bergman <jeremi@jeremibergman.com>
 * 
 */

function __autoload($class_name) {
	$file = "services/{$class_name}.php";
	
	if ( file_exists($file) ) {
		require_once($file);
	}
}

 $raw_contents = file_get_contents('php://input');
 
 $request = json_decode($raw_contents);
 
 // Prepare the response
 $response = new stdClass;
 $response->id = $request->id;
 
 list($class, $method) = explode('.', $request->method);
 
 try {
 	$class = new ReflectionClass($class);
	$service = $class->newInstanceArgs();
	
	$method_obj = $class->getMethod($method);
	
	$result = $method_obj->invokeArgs($service, $request->params);
	
	$response->error = null;
	$response->result = $result;
	
 } catch (Exception $e) {
 	$response->error = $e->getMessage();
	$response->result = null;
 }
 
 echo json_encode($response);