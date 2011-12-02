package ;

/*

Trying to create a mediator that does not exist, should throw exception at runtime.
agent.mediatorMap.createMediator( controlsView );

*/

#if flash9
import flash.display.MovieClip;
import flash.events.MouseEvent;
import sample.FlashContext;
#elseif js
import sample.view.BodyView;
import sample.view.ControlsView;
import jsSample.JSContext;
#end
import sample.view.BlueBoxView;
import sample.view.RedBoxView;
import sample.events.BoxEvent;
import xirsys.cube.events.AgentEvent;
import xirsys.cube.events.IEvent;

#if flash9
class Main extends MovieClip {
	private var agent : FlashContext;
	
	public static function main() {
		var app = new Main();
		flash.Lib.current.addChild( app );
	}
	
	public function new() {
		super();
		agent = new FlashContext( this, false );
		agent.addEventHandler( AgentEvent.STARTUP_COMPLETE, handleStartup );
		agent.initiate();
	}
	
	private function handleStartup( evt : IEvent ) : Void {
		var blue = new BlueBoxView();
		agent.container.addChild( blue );
		agent.mediatorMap.createMediator( blue );
		blue.visible = false;
	
		var red = new RedBoxView();
		agent.container.addChild( red );
		agent.mediatorMap.createMediator( red );
		
		var redBtn = new MovieClip();
		redBtn.graphics.beginFill( 0xFF0000 );
		redBtn.graphics.drawRect( 0, 0, 50, 50 );
		redBtn.graphics.endFill();
		redBtn.y = 160;
		addChild( redBtn );
		redBtn.addEventListener( MouseEvent.CLICK, handleRedClick );
		
		var blueBtn = new MovieClip();
		blueBtn.graphics.beginFill( 0x0000FF );
		blueBtn.graphics.drawRect( 0, 0, 50, 50 );
		blueBtn.graphics.endFill();
		blueBtn.y = 160;
		blueBtn.x = 60;
		addChild( blueBtn );
		blueBtn.addEventListener( MouseEvent.CLICK, handleBlueClick );
	}
#elseif js
class Main {
	private var agent : JSContext;
	
	public static function main() {
		haxe.Firebug.redirectTraces();
		var app = new Main();
	}
	
	public function new() {
		agent = new JSContext( new BodyView(), false );
		agent.addEventHandler( AgentEvent.STARTUP_COMPLETE, handleStartup );
		agent.initiate();
	}
	
	private function handleStartup( evt : IEvent ) : Void {
		var blue = new BlueBoxView( js.Lib.document.createElement( "div" ) );
		agent.container.view.appendChild( blue.view );
		agent.mediatorMap.createMediator( blue );
		blue.visible = false;
		
		var red = new RedBoxView( js.Lib.document.createElement( "div" ) );
		agent.container.view.appendChild( red.view );
		agent.mediatorMap.createMediator( red );
		
		var redBtn : js.Dom.Button = cast js.Lib.document.createElement( "input" );
		redBtn.type = "button";
		redBtn.value = "Red";
		redBtn.onclick = handleRedClick;
		agent.container.view.appendChild( redBtn );
		
		var blueBtn : js.Dom.Button = cast js.Lib.document.createElement( "input" );
		blueBtn.type = "button";
		blueBtn.value = "Blue";
		blueBtn.onclick = handleBlueClick;
		agent.container.view.appendChild( blueBtn );
		
		var controlsView = new ControlsView( js.Lib.document.createElement("div") );
		agent.container.view.appendChild(controlsView.view);
		agent.mediatorMap.createMediator( controlsView );
	}
#end
	
	private function handleRedClick( evt )
	{
		agent.eventDispatcher.dispatch( BoxEvent.SHOW_BOX, new BoxEvent( "red" ) );
	}
	
	private dynamic function handleBlueClick( evt )
	{
		agent.eventDispatcher.dispatch( BoxEvent.SHOW_BOX, new BoxEvent( "blue" ) );
	}
}