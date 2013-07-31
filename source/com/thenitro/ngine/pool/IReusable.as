package com.thenitro.ngine.pool {
	public interface IReusable {
		function get reflection():Class;
		function poolPrepare():void;
		function dispose():void;
	};
}