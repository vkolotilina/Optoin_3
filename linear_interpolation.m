function int_signal = linear_interpolation(y)

    l = length(y);
    int_l = 2 * l - 1;
    inter_sig = zeros(1, int_l);

    inter_sig(1:2:end) = y;

    for i = 2:2:int_l-1
      inter_sig(i) = (inter_sig(i-1) + inter_sig(i+1)) / 2;
    end

    int_signal = inter_sig;

end
%Функция линейной интерполяции
