/****
*
****/

package flash.display3D.textures;

#if (flash || display)
@:final extern class Texture extends TextureBase {
	function uploadCompressedTextureFromByteArray(data : flash.utils.ByteArray, byteArrayOffset : UInt, async : Bool = false) : Void;
	function uploadFromBitmapData(source : flash.display.BitmapData, miplevel : UInt = 0) : Void;
	function uploadFromByteArray(data : flash.utils.ByteArray, byteArrayOffset : UInt, miplevel : UInt = 0) : Void;
}
#else

using flash.display.BitmapData;
import openfl.gl.GL;
import openfl.gl.GLTexture;
import openfl.utils.ArrayBuffer;
import flash.utils.ByteArray;
#if html5
import js.html.Uint8Array;
#else
import openfl.utils.UInt8Array;
#end

class Texture extends TextureBase
{
   public var width : Int;
    public var height : Int;

	public function new(glTexture:GLTexture, width : Int, height : Int) {

		super (glTexture);
		this.width = width;
		this.height = height;

        GL.bindTexture (GL.TEXTURE_2D, glTexture);
        GL.texImage2D(GL.TEXTURE_2D, 0, GL.RGBA, width, height, 0, GL.RGBA, GL.UNSIGNED_BYTE, null);


	}


	public function uploadCompressedTextureFromByteArray(data:ByteArray, byteArrayOffset:Int, async:Bool = false):Void {

		// TODO

	}


	public function uploadFromBitmapData (bitmapData:BitmapData, miplevel:Int = 0):Void {

        var p = bitmapData.getRGBAPixels();
        uploadFromByteArray(p, 0, miplevel);

	}


	public function uploadFromByteArray(data:ByteArray, byteArrayOffset:Int, miplevel:Int = 0):Void {

        GL.bindTexture (GL.TEXTURE_2D, glTexture);

		#if html5
        var source:Uint8Array = new Uint8Array(data.length);
        data.position = 0;
        var i:UInt = 0;
        while (data.position < data.length) {
            source[i] = data.readUnsignedByte();
            i++;
        }
        #else
        var source:UInt8Array = new UInt8Array(data);
        #end

        GL.texSubImage2D(GL.TEXTURE_2D, miplevel, 0, 0, width, height, GL.RGBA, GL.UNSIGNED_BYTE, source);

	}
}

#end