function out = getdjconnection()
    try 
        out  = dj.conn('datajoint00.pni.princeton.edu', '', '', '', '', true); 
    catch 
        out  = dj.conn();
    end
end