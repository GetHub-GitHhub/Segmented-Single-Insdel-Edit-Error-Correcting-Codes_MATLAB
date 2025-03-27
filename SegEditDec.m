function [Decoded_VT] = SegEditDec(AfterEdit,t,k)
%   Segmented Indel ECC decoder
%   Input segment number t and segment length k, the received string AfterInsdel
%   Output VT codewords in marker+VT+marker structure


y = AfterEdit;

Prod = 1:k;
Decoded_VT = zeros(t,k);
p = zeros(t-3,1);
for i = 1:t-3   % To simplify the code, we only decode the first t-3 segments
    % Iteratively decoding, this comfirms the end of programme
    if mod( y(4:k+3)*Prod', 2*k ) ~= 0   % y(2:k+1) is not a VT codeword, decode by Lemma 2
        if y(k+7) == 0
            Decoded_VT(i,:) = EditDec_Del( y(4:k+2),0 );
            p(i) = k+8;
        else
            if y(k+8) == 0
                Decoded_VT(i,:) = EditDec_Sub( y(4:k+3),0 );
                p(i) = k+9;
            else
                Decoded_VT(i,:) = EditDec_Ins( y(4:k+4),0 );    
                p(i) = k+10;
            end
        end
    else
        Decoded_VT(i,:) = y(4:k+3);    % y(4:k+3) is a VT codeword, decode by Lemma 6
        % Object is to determine p_i, and let y = y(p_i+1:M)
        if sum(  y(k+4:k+6) ) < 3    % Case B1)
            p(i) = k+9;
            if y(k+8) ~= 0
                p(i) = k+10;
            end
        else
            if isequal(y(k+4:k+7), [1 1 1 0])  % Case B2)
                if y(k+8) == 0
                    p(i) = k+9;
                else
                    if y(k+9) == 1
                        p(i) = k+8;
                    else
                        p(i) = k+8;  % Case B2.1)
                        pattern0 = [1 0; 1 1];
                        if any(ismember(pattern0, y(k+10:k+11), 'rows'))  % Case B2.3), B2.4)
                            p(i) = k+10;
                        end
                    end
                end
            end
            
            if isequal(y(k+4:k+7), [1 1 1 1])   % Case B3) -- Cases B18)


                if isequal(y(k+8:k+11), [0 0 0 0])  % Case B3)
                    if isequal(y(2*k+13:2*k+16), [1 1 0 1])
                        p(i) = k+8;
                    end
                    if isequal(y(2*k+13:2*k+16), [1 1 1 0])
                        p(i) = k+8;
                    end
                    if isequal(y(2*k+13:2*k+16), [1 1 1 1])
                        p(i) = k+9;
                    end
                end

                if isequal(y(k+8:k+11), [0 0 0 1])  % Case B4)
                    p(i) = k+10;
                end

                if isequal(y(k+8:k+11), [0 0 1 0])  % Case B5)
                    p(i) = k+9;
                    pattern1 = [0 0; 0 1];
                    if any(ismember(pattern1, y(k+12:k+13), 'rows'))  % Case B5.1), B5.2)
                        p(i) = k+9;
                    end
                    if isequal(y(k+12:k+13), [1 0]) % Case B5.3)
                        p(i) = k+9;
                        if isequal(y(2*k+15:2*k+18), [1 1 1 0])
                            p(i) = k+10;
                        end
                        if isequal(y(2*k+15:2*k+18), [1 1 1 1])
                            p(i) = k+10;
                        end
                    end
                end

                if isequal(y(k+8:k+11), [0 0 1 1])  % Case B6)
                    p(i) = k+10;
                end

                if isequal(y(k+8:k+11), [0 1 0 0])  % Case B7)
                    p(i) = k+8;
                    if y(k+12) == 1 % Case B7.1)
                        if isequal(y(2*k+15:2*k+18), [1 1 1 1])
                            p(i) = k+10;
                        end
                    else     % Case B7.2)
                        if isequal(y(2*k+13:2*k+18), [0 1 1 1 1 0])
                            p(i) = k+10;
                        end
                        if isequal(y(2*k+13:2*k+18), [1 1 1 1 1 0])
                            delta = mod(y(k+13:2*k+12)*Prod',2*k);
                            if delta < k
                                p(i) = k+8;
                            else
                                p(i) = k+10;
                            end
                        end
                    end
                end

                if isequal(y(k+8:k+11), [0 1 0 1])  % Case B8)
                    p(i) = k+10;
                    if isequal(y(2*k+13:2*k+17), [1 1 1 0 1])
                        delta = mod(y(k+13:2*k+12)*Prod',2*k);
                            if delta < k
                                p(i) = k+8;
                            else
                                p(i) = k+10;
                            end
                    end
                end

                if isequal(y(k+8:k+11), [0 1 1 0])  % Case B9)
                    if y(k+12) == 0 % Case B9.2)
                        p(i) = k+9;
                    else            % Case B9.1)
                        if isequal(y(2*k+15:2*k+18), [1 1 0 1])
                            p(i) = k+9;
                        end
                        if isequal(y(2*k+15:2*k+18), [1 1 1 0])
                            p(i) = k+9;
                        end
                        if isequal(y(2*k+15:2*k+18), [1 1 1 1])
                            p(i) = k+10;
                        end
                    end
                end

                if isequal(y(k+8:k+11), [0 1 1 1])  % Case B10)
                    p(i) = k+10;
                end

                if isequal(y(k+8:k+11), [1 0 0 0])  % Case B11)
                    p(i) = k+8;
                end

                if isequal(y(k+8:k+11), [1 0 1 0])  % Case B13)
                    p(i) = k+10;
                end

                if isequal(y(k+8:k+11), [1 0 1 1])  % Case B14)
                    p(i) = k+10;
                end

                if isequal(y(k+8:k+11), [1 1 0 0])  % Case B15)
                    p(i) = k+8;
                end

                if isequal(y(k+8:k+11), [1 1 0 1])  % Case B16)
                    p(i) = k+9;
                    if isequal(y(2*k+14:2*k+17), [1 1 0 1])
                        p(i) = k+8;
                    end
                    if isequal(y(2*k+14:2*k+17), [1 1 1 0])
                        p(i) = k+8;
                    end
                    if isequal(y(2*k+14:2*k+17), [1 1 1 1])
                        p(i) = k+9;
                    end
                end

                if isequal(y(k+8:k+11), [1 1 1 0])  % Case B17)
                    p(i) = k+9;
                end

                if isequal(y(k+8:k+11), [1 1 1 1])  % Case B18)
                    p(i) = k+9;
                end

            end
        end
    end
y = y(p(i)+1:end);
end













end