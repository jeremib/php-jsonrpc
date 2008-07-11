/**
 * JSON-RPC Client
 * 
 * Based off of http://www.stubbles.net/wiki/Docs/JsonRpc
 * 
 * @author Jeremi Bergman <jeremi@jeremibergman.com>
 */
var JsonRpcClient = function(clientObj) {
	this.createId = function() {
		return Math.floor(Math.random()*10001);
	}
	
	this.doCall = function(url, classAndMethod, args, callback) {
		var id = this.createId();
		
		var jsonRpcReq = {
			method: classAndMethod,
			params: args,
			id: id
		};

		
		new Ajax.Request(url, {
			method: 'post',
			postBody: $H(jsonRpcReq).toJSON(),
			onSuccess: callback			
		});

		return id;
	};
};
