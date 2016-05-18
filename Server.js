var Server = require('socket.io');
var io = new Server(8124);
io.sockets.on('connection', function (socket) {
	socket.on('join',function(username) {
		socket.broadcast.emit('broadcast_join', username);
	});
	socket.on('sendchat', function(username, data) {
		socket.broadcast.emit('chat', username, data);
	});
});
