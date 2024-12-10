function freq = tone2freq_new(tone, scale, noctave, rising)

 

    % Ensure the tone is within the valid range of 1 to 7
    if (tone < 1 || tone > 7)
        error('The tone must be between 1 and 7');
    end
    
    % C调中1-7的基准频率数组（标准A4=440Hz，相应的C4约为261.5Hz）这些频率是基于A4=440Hz计算出的C大调音阶
    C_scale_base_freqs = [261.5, 293.5, 329.5, 349, 391.5, 440.00, 494];

    % Semitone intervals for each scale, where index 1 is for C scale, 2 for D, etc.
    % This array corresponds to the semitone intervals from C to B and then C again (higher octave)
    scale_semitones = [0, 2, 4, 5, 7, 9, 11, 12]; % C, D, E, F, G, A, B, C (higher octave)

    % Check if the scale input is valid (must be a letter from A to G)
    if scale (< 'A' || scale > 'G')
        error('The scale must be between A and G');
    end
    
    % Get the frequency of the main tone for the given scale
    main_freq = C_scale_base_freqs(scale - 'C' + 1);

    % Semitone mapping for tones without any accidental (sharp or flat)
    semitone_map = [0, 2, 4, 5, 7, 9, 11];

    % Calculate the number of semitones from the main tone
    semitone_from_main = semitone_map(tone) + rising;

    % Calculate the frequency of the tone
    freq = main_freq * 2^(semitone_from_main/12) * 2^noctave;
end
%