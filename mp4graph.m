% Sample data
y = dlc(:,7);
x = 1:2501;

% Create a figure and axes
figure;
axesHandle = axes;

% Create an animated line object
lineHandle = animatedline(axesHandle, 'Color', 'b', 'LineWidth', 2);

% Set axis limits
ylim(axesHandle, [0, max(dlc(:,7))]);
xlim(axesHandle, [1, 2501]);


% Loop through the data and update the line
numFrames = numel(x);
frames = cell(1, numFrames); % Preallocate frames array
for i = 1:numFrames
    % Add a point to the line
    addpoints(lineHandle, x(i), y(i));
    
    % Update the plot
    drawnow;
    
    % Capture the frame
    frames{i} = getframe(gcf);
    
    % Pause for a short duration to control the animation speed
    pause(1/115);
end

% Create an MP4 file
filename = 'animation.mp4';
frameRate = 115; % Set the desired frame rate (frames per second)

writerObj = VideoWriter(filename, 'MPEG-4');
writerObj.FrameRate = frameRate;
open(writerObj);

for i = 1:numFrames
    frame = frames{i};
    writeVideo(writerObj, frame);
end

close(writerObj);

disp('Animation saved as MP4 file.');



