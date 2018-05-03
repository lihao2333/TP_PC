function  demod_out = demodulation_soft(demod_in,mod_mode,rou)


demod_data = reshape(demod_in,1,[]);
if mod_mode==2 %% BPSK
    demod_data=demod_data*exp(-j*pi/4);
end

L = length(demod_data);
demod_temp=zeros(2,L);
demod_temp(1,:)=real(demod_in);
demod_temp(2,:)=imag(demod_in);
demod_soft = demod_temp;

switch (mod_mode)
    case 2    %% BPSK
        D=1;
        demod_out = demod_soft(1,:)*4*D*rou;
    case 4    %% QPSK
        D=1/sqrt(2);
        demod_out = reshape(demod_temp,1,2*L)*4*D*rou;
    case 16    %% 16QAM
        D=1/sqrt(10);
        demod_bits=zeros(4,L);
        demod_bits(1,:) = demod_soft(1,:)*4*D*rou;
        demod_bits(2,:) = demod_soft(2,:)*4*D*rou;
        demod_bits(3,:) = -(abs(demod_soft(1,:))-2*D)*4*D*rou;
        demod_bits(4,:) = -(abs(demod_soft(2,:))-2*D)*4*D*rou;
        demod_out = reshape(demod_bits,1,[]);   
    case 64  %% 64QAM    
        D=1/sqrt(42);
        demod_bits=zeros(6,L);
        demod_bits(1,:) = demod_soft(1,:)*4*D*rou;
        demod_bits(2,:) = demod_soft(2,:)*4*D*rou;
        demod_bits(3,:) = (4*D-abs(demod_soft(1,:)))*4*D*rou;
        demod_bits(4,:) = (4*D-abs(demod_soft(2,:)))*4*D*rou;
        demod_bits(5,:) = (2*D-abs(abs(demod_soft(1,:))-4*D))*4*D*rou;
        demod_bits(6,:) = (2*D-abs(abs(demod_soft(2,:))-4*D))*4*D*rou;
        demod_out = reshape(demod_bits,1,[]);
    otherwise
        disp('Error! Please input again');        
end

