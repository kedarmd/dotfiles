import fs from 'fs';
import path from 'path';
import { exec } from 'child_process';

/**
 * Function to update TMUX theme
 * @param {string} theme
 * @param {(theme: string, source: string, targetPath: string, config?: string, callback?: () => void)=> void} setThemeCallback
 * @returns {void}
 */
export function setTmuxTheme(theme) {
    const startMarker = '# Theme';
    const endMarker = '# End of theme setup';
    const tmuxFilePath = path.join(
        process.env.HOME,
        'development',
        'dotfiles',
        'tmux.conf',
    );

    fs.readFile(tmuxFilePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error while reading tmux.conf');
            return;
        }
        const startIdx = data.indexOf(startMarker);
        const endIdx = data.indexOf(endMarker);
        if (startIdx === -1 || endIdx === -1) {
            console.error('Could not find theme markers in tmux.conf');
            return;
        }
        const beforeContent = data.substring(0, startIdx);
        const endContent = data.substring(endIdx + endMarker.length + 1);
        const newTheme = readTmuxThemeFile(theme);
        const newThemeConfig = `${startMarker}
${newTheme}
${endMarker}
`;
        const newConfig = beforeContent + newThemeConfig + endContent;
        fs.writeFile(tmuxFilePath, newConfig, 'utf8', (err) => {
            if (err) {
                console.error('Error writing tmux.conf file');
                return;
            }
            console.log(`Updated TMUX theme to ${theme}`);
            exec('tmux source-file ~/.tmux.conf');
        });
    });
}

function readTmuxThemeFile(theme) {
    const themePath = path.join(
        process.env.HOME,
        'development',
        'dotfiles',
        'themes',
        'tmux',
        `${theme}.conf`,
    );
    const data = fs.readFileSync(themePath, 'utf8', (err, data) => {
        if (err) {
            console.error(`Error while reading tmux theme file: ${theme}.conf`);
            return;
        }
        return data;
    });
    return data;
}
