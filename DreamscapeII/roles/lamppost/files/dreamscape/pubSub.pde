import org.zeromq.ZMQ;

String subscribeTo = "processing";

void psenvsub () {
    // Prepare our context and subscriber
    ZMQ.Context context = ZMQ.context(1);
    ZMQ.Socket subscriber = context.socket(ZMQ.SUB);
    println("started sub thread");

    subscriber.connect("tcp://localhost:6000");
    subscriber.subscribe(subscribeTo.getBytes());
    while (!Thread.currentThread ().isInterrupted ()) {
        // Read message contents
        String[] message = subscriber.recvStr().split("\\|");
	println("recved zmq");
        String[] contents = message[1].split("#");

        //println("hallo", message[0], "m1", message[1]);

       	println("sub button:", contents[0], contents[1]);

	if (contents[0].equals("giraffe_side")) {
		println("giraffe", contents[1]);

		if (contents[1].equals("1")){
			println("giraffe white: on");
			lx.addEffect(white_wash_effect);
		} else {
			println("giraffe white: off");
	        	lx.removeEffect(white_wash_effect);
	        	lx.removeEffect(white_wash_effect);

			lx.goNext();
			LXTransition tran = lx.getTransition();
			tran.setDuration(10); 
		}

	} else if (contents[0].equals("igloo_side")) {
		println("igloo", contents[1]);

		if (contents[1].equals("1")){
			println("igloo white: on");
			lx.addEffect(white_wash_effect2);
		} else {
			println("igloo white: off");
	        	lx.removeEffect(white_wash_effect2);
	        	lx.removeEffect(white_wash_effect2);

			lx.goNext();
			LXTransition tran = lx.getTransition();
			tran.setDuration(10); 
		}

	} 


        //println(contents[1]);
        //rotationPosition = Float.parseFloat(contents[0]);
        //rotationVelocity = Float.parseFloat(contents[1]);

    }
    subscriber.close();
    context.term ();
}

class ZMQ_pub {
    String message;
    String topic;
    String which;
    ZMQ.Socket publisher;

    public ZMQ_pub(String master, String topic, String which){
        ZMQ.Context context = ZMQ.context(1);
        this.publisher = context.socket(ZMQ.PUB);
        this.publisher.connect("tcp://" + master + ":6001");
        this.topic = topic;
        this.which = which;
    }

    void sendMessage(String value){
        String sayWhat = this.topic + "|" + this.which + "#" + value;
        this.publisher.send(sayWhat);
    }
}

class ZMQ_sub {
    String message;
    String topic;
    String which;
    String subscribeTo;
    ZMQ.Socket subscriber;

    public ZMQ_sub(String master, String topic, String which){
        this.subscribeTo = topic + "|" + which;

        ZMQ.Context context = ZMQ.context(1);
        this.subscriber = context.socket(ZMQ.SUB);
        this.subscriber.connect("tcp://" + master + ":6001");
        this.subscriber.subscribe(this.subscribeTo.getBytes());
        this.topic = topic;
        this.which = which;
    }

    // private recvMessage(){
    //     String message = subscriber.recvStr();
    //     // String[] contents = messa

    // }
}
