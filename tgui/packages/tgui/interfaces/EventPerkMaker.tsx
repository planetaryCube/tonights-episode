// THIS IS A GS13 UI FILE
import { Section, Stack, Input, Button, TextArea } from 'tgui-core/components';
import { useState } from 'react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
    items: String[];
    ckeys: String[];
};

type NewPerkData = {
    name: string;
    description: string;
    items: string;
    ckeys: string;
    expiry_date: string;
};

export const EventPerkMaker = (props) => {
    const { act } = useBackend<NewPerkData>();
    const { data } = useBackend<Data>();
    const {items, ckeys} = data;

    const [name, setName] = useState('');
    const [description, setDescription] = useState('');
    const [ckey, setCkey] = useState('');
    const [item, setItem] = useState('');
    const [itemAmount, setItemAmount] = useState('');
    const [expiryDate, setExpiryDate] = useState('');

    return(
        <Window title={'Create a new perk'} width={300} height={380}>
        <Window.Content>
        <Section>
        <Stack vertical fill>
            <Stack.Item>
                Name:<br/>
                <Input 
                maxLength={100}
                value = {name}
                placeholder="Name of the event perk"
                onChange={setName}
                width = {15}
                />
            </Stack.Item>
            <Stack.Item>
                Description:<br/>
                <TextArea
                    fluid
                    value = {description}
                    placeholder="Description of the event perk"
                    onChange={setDescription}
                    height = {10}
                />
            </Stack.Item>
            <Stack.Item>
                Items:<br/>
                <ul>
                    {items.map((current_item) => (<li>{current_item}</li>))}
                </ul>
                <Input 
                value = {item}
                placeholder="Item path"
                onChange={setItem}
                width = {15}
                />
                <Input 
                value = {itemAmount}
                placeholder="Amount"
                onChange={setItemAmount}
                width = {4}
                />
                <Button
                disabled = {item.trim().length == 0 || itemAmount.trim().length == 0}
                onClick={() => act("add_item", {item: item,
                                                item_amount: itemAmount})}
                >
                    Add
                </Button>
            </Stack.Item>
            <Stack.Item>
                Ckeys:<br/>
                <ul>
                    {ckeys.map((current_ckey) => (<li>{current_ckey}</li>))}
                </ul>
                <Input 
                value = {ckey}
                placeholder="Ckey..."
                onChange={setCkey}
                width = {15}
                />
                <Button 
                disabled = {ckey.trim().length == 0}
                onClick={() => act("add_ckey", {ckey: ckey})}>
                    Add
                </Button>
            </Stack.Item>
            <Stack.Item>
                Expiry date:<br/>
                <Input 
                value = {expiryDate}
                maxLength={8}
                placeholder="Expiry date..."
                onChange={setExpiryDate}
                width = {15}
                />
            </Stack.Item>
            <Stack.Item>
            <Button
            onClick={() => act("create_perk", {name: name, 
                                            description: description,
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
