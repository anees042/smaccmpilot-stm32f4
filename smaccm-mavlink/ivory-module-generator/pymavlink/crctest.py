import mavutil
import array

print "module CanonicalCRC where"
print "-- autogenerated using mavutil x25crc"
print "crc :: [(Int, Int, Int)]"
print "crc ="
for a in range (0,256):
    for b in range (0,256):
        if a == 0 and b == 0:
            sep = "["
        else:
            sep = ","
        pair = array.array('B', [a, b])
        print( "  %s (%d, %d, %d)"
            % (sep, a, b, mavutil.x25crc(pair).crc) )
print "  ]"