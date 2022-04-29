% ECE 444 HW6
% Fall 2020
% Thomas Smallarz
% 
% B Matrix is #freq x K stages x 3 coef
% A Matrix is #freq x K stages x 3 coef
% G Matrix is 1 x #freq

function [] = GenerateHeader(B,A,G)
    fid = fopen('coef.h','w');
    fprintf(fid,'#define K %d \n',size(B,2));
    % *******************************
    % ***** CREATE G Coef Array *****
    % *******************************
    fprintf(fid,'float G[%d] = {',length(G));
        for i = 1:length(G)
            if i == length(G)
                fprintf(fid,'%.6f',G(i));
            else
                fprintf(fid,'%.6f, ',G(i));
            end
        end
    fprintf(fid,'};\n');
    % *******************************
    % ***** CREATE B Coef Array *****
    % *******************************
    fprintf(fid,'float B[%d][K] = {\n',size(B,1));
        for i = 1:size(B,1)
           fprintf(fid,'\t{');
                for j = 1:size(B,2)
                    if j == size(B,2)
                        fprintf(fid,'\n\t\t%.6f',B(i,j));
                    elseif mod(j,5) == 0
                        fprintf(fid,'\n\t\t%.6f,',B(i,j));
                    else
                        fprintf(fid,'\t%.6f,',B(i,j));
                    end
                end
            if i == size(B,1)
                fprintf(fid,'\t}\n');
            else
                fprintf(fid,'\t},\n');
            end
        end    
    fprintf(fid,'};\n\n');
    
    % *******************************
    % ***** CREATE A Coef Array *****
    % *******************************
    fprintf(fid,'float A[%d][K][2] = {\n',size(A,1));
        for i = 1:size(A,1)
           fprintf(fid,'\t{\n');
                for j = 1:size(A,2)
                    fprintf(fid,'\t\t{');
                    for k = 1:size(A,3)
                        if k == size(A,3)
                            fprintf(fid,'\t%.6f',A(i,j,k));
                        else
                            fprintf(fid,'%.6f,',A(i,j,k));
                        end
                    end
                    if j == size(B,2)
                        fprintf(fid,'}\n');
                    else
                        fprintf(fid,'},\n');
                    end
                end
            if i == size(B,1)
                fprintf(fid,'\t}\n');
            else
                fprintf(fid,'\t},\n');
            end
        end    
    fprintf(fid,'};\n\n');
    
    % *************************
    % ***** CREATE BUFFER *****
    % *************************
    fprintf(fid,'float buf[K][2] = { \n');
    for i = 1:size(A,2)
        if i == size(A,2)
            fprintf(fid,'{0,0}\n');
        elseif mod(i,8)==0
            fprintf(fid,'{0,0},\n');
        else
            fprintf(fid,'{0,0}, ');
        end
        
    end
    fprintf(fid,'};\n');
    
    fclose(fid);
end

