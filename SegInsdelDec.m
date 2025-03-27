function [Decoded_VT] = SegInsdelDec(AfterInsdel,t,k)
%   Segmented Indel ECC decoder
%   Input segment number t and segment length k, the received string AfterInsdel
%   Output VT codewords in marker+VT+marker structure


y = AfterInsdel;% Set M to be the length of received strirng

Prod = 1:k;
Decoded_VT = zeros(t,k);
p = zeros(t,1);
for i = 1:t-3   % To simplify the code, we only decode the first t-3 segments
    % Iteratively decoding, this comfirms the end of programme
    if mod( y(2:k+1)*Prod',k+1 ) ~= 0   % y(2:k+1) is not a VT codeword, decode by Lemma 2
        if y(k+5) == 0
            Decoded_VT(i,:) = InsdelDec_Del( y(2:k),0 );
            p(i) = k+6;
        else
            Decoded_VT(i,:) = InsdelDec_Ins( y(2:k+2),0 );
            p(i) = k+8;
        end
    else
        Decoded_VT(i,:) = y(2:k+1);    % y(2:k+1) is a VT codeword, decode by Lemma 3
        % Object is to determine p_i, and let y = y(p_i+1:end)
        if sum(  y(k+2:k+4) ) < 3    % Case A1)
            p(i) = k+8;
        else
            if isequal(y(k+2:k+5), [1 1 1 0])  % Case A2)
                if y(k+7) == 1          % Case A2.1)
                    p(i) = k+6;
                else                    % Case A2.2)
                    if y(k+8) == 0
                        p(i) = k+6;
                    else
                        pattern2_2 = [1 1 0 1 0 0;1 1 0 1 0 1;1 1 0 1 1 0];
                        if any(ismember(pattern2_2, y(2*k+9:2*k+14), 'rows'))
                            p(i) = k+6;
                        else
                            p(i) = k+8;
                        end
                    end
                end
            end
            if isequal(y(k+2:k+7), [1 1 1 1 0 0])  % Case A3)
                if y(k+8) == 0
                    p(i) = k+6;
                else
                    pattern3 = [1 1 0 1 0 0;1 1 0 1 0 1;1 1 0 1 1 0];
                    if any(ismember(pattern3, y(2*k+9:2*k+14), 'rows'))
                        p(i) = k+6;
                    else
                        p(i) = k+8;
                    end
                end
            end
            if isequal(y(k+2:k+7), [1 1 1 1 0 1])  % Case A4)
                if y(k+8) == 1
                    p(i) = k+8;
                else
                    if y(k+9) == 1
                        if y(2*k+12) == 0               % Table VIII, Row 1
                            p(i) = k+7;
                        else
                            if isequal(y(2*k+13:2*k+14), [1 0])  % Table VIII, Row 11
                                p(i) = k+7;
                            else
                                if isequal(y(2*k+13:2*k+14), [1 1])  % Table VIII, Row 12
                                    p(i) = k+8;
                                end
                            end
                        end
                    else
                        if y(k+10) == 1     % Case A4.1)
                            p(i) = k+7;
                            if isequal(y(2*k+11:2*k+16), [1 1 1 1 0 1])     % Row 2 & 10
                                p(i) = k+8; % Table VIII, Row 10
                            end
                        else                % Case A4.2)

                            p(i) = k+7;     % a',b',c', i.e., Row 1-5

                            patternd_1d_6 = [1 1 1 1 1 0; 0 1 1 1 1 0];
                            if any(ismember(patternd_1d_6 , y(2*k+9:2*k+14), 'rows'))  % (d'-1),
                                if mod( y(k+10:2*k+9)*Prod',k+1 ) ~= 0
                                    p(i) = k+7;
                                else
                                    p(i) = k+8;
                                end
                            end

                            patternd_2d_5d_8 = [1 1 1 1 0 1; 0 1 1 1 0 1; 1 1 1 1 0 0; 0 1 1 1 0 0];
                            if any(ismember(patternd_2d_5d_8 , y(2*k+9:2*k+14), 'rows'))  % (d'-2),(d'-5),(d'-7)
                                if y(2*k+9) == 0    % (d'-2)
                                    p(i) = k+8;
                                else
                                    if mod( y(k+9:2*k+8)*Prod',k+1 ) == 0   % (d'-2),(d'-5),(d'-7)
                                        p(i) = k+7;
                                    else
                                        p(i) = k+8;
                                    end
                                end
                            end

                            patternd_3 = [1 1 1 0 1 1; 0 1 1 0 1 1];
                            if any(ismember(patternd_3 , y(2*k+9:2*k+14), 'rows'))  % (d'-3)
                                if y(2*k+9) == 0
                                    p(i) = k+8;
                                else
                                    if isequal(y(2*k+15:2*k+16), [0 0])
                                        p(i) = k+7;
                                    end
                                    if isequal(y(2*k+15:2*k+16), [0 1])
                                        p(i) = k+8;
                                    end
                                end
                            end

                            patternd_4d_7d_9 = [0 1 0 1 1 1; 1 1 0 1 1 1; 1 0 1 1 1 1; 0 0 1 1 1 1; 0 1 1 1 1 1];
                            if any(ismember(patternd_4d_7d_9 , y(2*k+9:2*k+14), 'rows'))    % (d'-4),(d'-6),(d'-8)
                                p(i) = k+8;
                            end


                            pattern_e_d9_d7 = [1 1 1 1 1 1; 1 0 1 1 1 1; 0 1 1 1 1 1; 0 0 1 1 1 1];
                            if any(ismember(pattern_e_d9_d7, y(2*k+9:2*k+14), 'rows'))      % (e'),(d'-8),(d'-6)
                                if y(2*k+9) == 0
                                    p(i) = k+8;
                                else
                                    if y(2*k+10) == 1
                                        if y(2*k+15:2*k+16) == [0 0]
                                            if mod(y(k+9:2*k+8)*Prod',k+1) == 0
                                                p(i) = k+7;
                                            else
                                                p(i) = k+8;
                                            end
                                        else
                                            p(i) = k+8;
                                        end
                                    else
                                        p(i) = k+8;
                                    end
                                end
                            end

                        end
                    end
                end
            end
            if isequal(y(k+2:k+7), [1 1 1 1 1 0])  % Case A5)
                if y(k+8) == 0
                    p(i) = k+6;
                else
                    pattern_5 = [1 1 0 1 0 0;1 1 0 1 0 1;1 1 0 1 1 0];
                    if any(ismember(pattern_5, y(2*k+9:2*k+14), 'rows'))
                        p(i) = k+6;
                    else
                        p(i) = k+8;
                    end
                end
            end
            if isequal(y(k+2:k+7), [1 1 1 1 1 1])  % Case A6)
                p(i) = k+6;
            end
        end
    end
    y = y(p(i)+1:end);
end












end