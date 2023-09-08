function getRandomMessage() {
  let index = Math.floor(Math.random() * textVariants.length);
  let randomText = textVariants[index];
  let message = {
    text: randomText,
    isIncoming: Math.random() < 0.5,
  };
  return message;
}

let textVariants = [
  "Привет!",
  "你跟我一起去吗？",
  "Рандомное сообщение",
  "List of Latin phrases",
  "select a random element",
  "Пара шафрановых желтушек",
  "implements the above approach",
  "Московский архитектурный институт",
  "организована команда StarCraft: Brood War",
  "австралийская теннисистка, победительница 62",
];
