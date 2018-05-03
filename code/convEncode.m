%% Rate 1/2 Feedback encoder with 8-states used in 3GPP cellular 3G/4G standard

function [cenc_o,msg]=convEncode(LM,CL,TREL,FeedBackCoef)
% CL = 4  % constrain length
% GenPoly0_1by2 = 13 % in octal
% GenPoly1_1by2 = 15
% FeedBackCoef = [1,0,1,1];% tail bits for computing i/p bits needed to terminate trellis at state =0.
% TREL = poly2trellis(CL, [GenPoly0_1by2, GenPoly1_1by2], GenPoly0_1by2)    % trellis used for codec
% LM = LM + 2*(CL-1); % space for start & tail bits

%% Verify trellis-structure is OK
[isok, status] = istrellis(TREL)
randn('state', sum(100*clock)); % initialize to random state

%% The encoder is assumed to have both started and ended at the all-zeros state
%% Ensure msg is s.t. trellis starts at "0" state and ends at "0" state.
%%  Generate Random binary stream & encode

msg1(1 : CL-1) = zeros(1, CL-1); % 1st (CL-1) bits must be 0
msg1(CL : LM -CL+1) = randi([0,1],1,LM -2*CL +2) ; % Random data

% Encode first part of msg, recording final state for later use.
[cenc_o1, final_state1] = convenc(msg1, TREL);

% Rest of msg depends on final_state1; it makes trellis terminate at final_state=0.
bvec_fs = bitget(final_state1, (CL-1) : -1 : 1); % All possible binary-vectors of length EncoderN
for idx = 1 : (CL-1)
    msg2(idx) = rem( [0, bvec_fs]*FeedBackCoef', 2);
    bvec_fs = [0, bvec_fs(1: (end-1))];
end
[cenc_o2, final_state] = convenc(msg2, TREL, final_state1);

msg = [msg1, msg2]; clear msg1 msg2
[cenc_o] = [cenc_o1, cenc_o2]; clear cenc_o1 cenc_o2

if final_state ~= 0
    disp('trellis not terminated properly: check last (CL-1) bits of mesg')
    return
end
