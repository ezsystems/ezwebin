/* Insert tags supplied as arguments back into main document */

function insertMedia()
{
    for( k = 0; k < arguments.length; k++ )
    {
        document.write( arguments[k] );
    }
}