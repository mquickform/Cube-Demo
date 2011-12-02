package jsSample;

import xirsys.cube.core.Agent;
import js.Dom.HtmlDom;
import sample.events.BoxEvent;
import xirsys.cube.events.IEvent;
import xirsys.cube.events.AgentEvent;
import sample.controller.ShowBoxCommand;
import sample.view.BlueBoxView;
import sample.view.BlueBoxViewMediator;
import sample.view.RedBoxView;
import sample.view.RedBoxViewMediator;
import sample.view.ControlsView;
import sample.view.ControlsViewMediator;

class JSContext extends Agent<Dynamic,IEvent> {
	
	public function new( container : Dynamic, autoStart : Bool )
	{
		super( container, autoStart );
	}
	
	override public function initiate()
	{
		mediatorMap.mapView( BlueBoxView, BlueBoxViewMediator );
		mediatorMap.mapView( RedBoxView, RedBoxViewMediator );
		mediatorMap.mapView(ControlsView, ControlsViewMediator);
		commandMap.mapEvent( BoxEvent.SHOW_BOX, ShowBoxCommand, BoxEvent );
		dispatch( AgentEvent.STARTUP_COMPLETE, null );
	}
}