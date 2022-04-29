% ECE444 HW7
% Fall 2020
% Thomas Smallarz

% B is Length(B) sized array of FIR impulse response coef
% buf is Length(B)-1 size array of zeros for Buffer (past input values)

function [] = GenerateHeader(B,k)
    fid = fopen('coef.h','w');
    fprintf(fid,'#define Lb %d // Length of B coef\n',length(B));
    fprintf(fid,'#define Lbuf %d // Length of buffer\n',length(B)-1);
    fprintf(fid,'#define sh %d // shift for fixed-point\n',k);

    % *******************************
    % ***** CREATE B Coef Array *****
    % *******************************
    fprintf(fid,'int16_t B[Lb] = {\n');
        for i = 1:length(B)
            if(mod(i,5)==0)
                fprintf(fid,'\t%10.0f,\n',B(i)*2^k);
            elseif i == length(B)
               fprintf(fid,'\t%10.0f',B(i)*2^k); 
            else
               fprintf(fid,'\t%10.0f,',B(i)*2^k);
            end
        end
    fprintf(fid,'\n};\n\n');
        
    % *************************
    % ***** CREATE BUFFER *****
    % *************************
    fprintf(fid,'int16_t buf[Lbuf] = { \n');
        for i = 1:length(B)-1
            if mod(i,10)==0
                fprintf(fid,'\t0,\n');
            elseif i == length(B)-1
                fprintf(fid,'\t0 ');
            else
                fprintf(fid,'\t0, ');
            end
        end
    fprintf(fid,'\n};\n');
    
    fclose(fid);
end
