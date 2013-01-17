#include <smavlink/pack.h>
#include "smavlink_message_mission_request.h"
void smavlink_send_mission_request(struct mission_request_msg* var0,
                                   struct smavlink_out_channel* var1,
                                   struct smavlink_system* var2)
{
    uint8_t local0[4U] = {0, 0, 0, 0};
    uint8_t(* ref1)[4U] = &local0;
    uint16_t deref2 = *&var0->mission_request_seq;
    
    smavlink_pack_uint16_t(ref1, 0, deref2);
    
    uint8_t deref3 = *&var0->target_system;
    
    smavlink_pack_uint8_t(ref1, 2, deref3);
    
    uint8_t deref4 = *&var0->target_component;
    
    smavlink_pack_uint8_t(ref1, 3, deref4);
    smavlink_send_ivory(var1, var2, 40, ref1, 4, 230);
    return;
}