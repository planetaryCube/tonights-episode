// THIS IS A GS13 UI FILE
import { Section, Stack, Input, Button } from 'tgui-core/components';
import { useState } from 'react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type NewPerkData = {
    name: string;
    description: string;
    items: string;
    ckeys: string;
    expiry_date: string;
};

export const EventPerkMaker = (props) => {
    const { act } = useBackend<NewPerkData>();

    const [name, setName] = useState('');
    const [description, setDescription] = useState('');
    const [ckeys, setCkeys] = useState('');
    const [items, setItems] = useState('');
    const [expiryDate, setExpiryDate] = useState('');
    return(
        <Window title={'Create a new perk'} width={200} height={500}>
        <Window.Content>
        <Section>
        <Stack>
            <Stack.Item>
                Name:
                <Input 
                maxLength={100}
                value = {name}
                placeholder="Name..."
                onChange={setName}
                />
            </Stack.Item>
            <Stack.Item>
                Description:
                <Input 
                value = {description}
                placeholder="Description..."
                onChange={setDescription}
                />
            </Stack.Item>
            <Stack.Item>
                Items:
                <Input 
                value = {items}
                placeholder="Items..."
                onChange={setItems}
                />
            </Stack.Item>
            <Stack.Item>
                Ckeys:
                <Input 
                value = {ckeys}
                placeholder="Ckeys..."
                onChange={setCkeys}
                />
            </Stack.Item>
            <Stack.Item>
                Expiry date:
                <Input 
                value = {expiryDate}
                placeholder="Expiry date..."
                onChange={setExpiryDate}
                />
            </Stack.Item>
            <Stack.Item>
            <Button
            // disabled = {!perk.available}
            onClick={() => act("create_perk", {name: name, 
                                            description: description,
                                            items: items,
                                            ckeys: ckeys,
                                            expiry_date: expiryDate})}
            >
                Submit
            </Button>
            </Stack.Item>
        </Stack>
        </Section>
        </Window.Content>
        </Window>
    );
};
