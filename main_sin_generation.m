clear;
Fs = 100;  % Частота дискретизации (Гц)
T = 1/Fs;   % Период дискретизации (с)
t = 0:T:1;

f = input('Введите частоту(от 0 до 50 Гц): ');

error = zeros(1, 1);

y = sin(2*pi*f*t); %Генерируем синусоидальный сигнал на выбранной частоте

dec_y = decimate_signal(y); %Децимируем исходный сигнал

int_y = linear_interpolation(dec_y); %Интерполируем сигнал

%Для корректного вычисления ошибки и построения графика проверяем равнозначность длины массивов
if length(int_y) > length(y)
  int_y = int_y(1:length(y));
elseif length(int_y) < length(y)
  int_y = [int_y, zeros(1, length(y) - length(int_y))];
end

error = mean((y - int_y).^2);
fprintf('Выбранная частота: %.1f Гц, Ошибка: %.4f\n', f, error);

dec_T = 2*T;
dec_t = (0:length(dec_y)-1)*dec_T;
int_t = (0:length(int_y)-1)*T;

figure;
plot(t, y, dec_t, dec_y, 'g--', int_t, int_y, 'r-.');
grid on;
title(['Сигналы на частоте ', num2str(f), ' Гц']);
xlabel('Время (с)');
ylabel('Амплитуда');
legend('Исходный сигнал', 'Децимированный сигнал', 'Интерполированный сигнал');

f_all = 0:1:50;

errors = zeros(size(f_all));

for i = 1:length(f_all)
  f1 = f_all(i);
  y1 = sin(2*pi*f1*t);
  dec_y1 = decimate_signal(y1);
  int_y1 = linear_interpolation(dec_y1);

  if length(int_y1) > length(y1)
    int_y1 = int_y1(1:length(y1));
  elseif length(int_y1) < length(y1)
    int_y1 = [int_y1, zeros(1, length(y1) - length(int_y1))];
  end

    errors(i) = mean((y1 - int_y1).^2);

end

figure;
plot(f_all, errors);
title('Величина ошибки в зависимости от частоты');
xlabel('Частота (Гц)');
ylabel('Среднеквадратичная ошибка');
grid on;






