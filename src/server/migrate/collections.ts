import { oxmysql } from '@overextended/oxmysql';
import { triggerClientCallback } from '../utils';
import { TAppearance } from '@typings/appearance';
import { saveAppearance } from '../appearance/setters';

const delay = (ms: number) => new Promise(res => setTimeout(res, ms));

const migrate = async (src: string) => {
    const response: any = await oxmysql.query('SELECT * FROM `appearance`');
    if (!response) {
        console.log('No appearances found to migrate.');
        return;
    }

    console.log(`Starting migration for ${response.length} appearances...`);

    const playerSrc = parseInt(src);

    for (const element of response) {
        if (element.skin && element.clothes) {
            const skin = typeof element.skin === 'string' ? JSON.parse(element.skin) : element.skin;
            const clothes = typeof element.clothes === 'string' ? JSON.parse(element.clothes) : element.clothes;
            const tattoos = element.tattoos ? (typeof element.tattoos === 'string' ? JSON.parse(element.tattoos) : element.tattoos) : [];
            const appearanceData: TAppearance = {
                model: skin.model,
                hairColor: skin.hairColor,
                headBlend: skin.headBlend,
                headStructure: skin.headStructure,
                headOverlay: clothes.headOverlay,
                drawables: clothes.drawables,
                props: clothes.props,
                tattoos: tattoos,
            };

            await triggerClientCallback('bl_appearance:client:migration:setAppearance', src, {
                type: 'bl_appearance',
                data: appearanceData
            });

            await delay(1000);
            const newAppearance = await triggerClientCallback('bl_appearance:client:getAppearance', src) as TAppearance;
            await saveAppearance(playerSrc, element.id, newAppearance, true);

            console.log(`Migrated appearance for id: ${element.id}`);
            await delay(100);
        }
    }
    console.log('Migration finished.');
};

export default migrate;
