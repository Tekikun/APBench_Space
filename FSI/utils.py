import re
import openai

def extract_numbers(text):
    # Define a regular expression pattern to match numbers with optional commas, decimals, and negative signs
    pattern = re.compile(r'-?\d+(?:,\d{3})*(?:\.\d+)?|-?\d+\.\d+|-?\d+')
    
    # Find all matches in the text
    matches = pattern.findall(text)
    
    # Remove commas from the numbers and convert them to float or int
    numbers = [float(match.replace(',', '')) if '.' in match else int(match.replace(',', '')) for match in matches]
    
    return numbers

# Function to find the index of the first empty sublist
def find_first_empty_index(lst):
    for idx, sublist in enumerate(lst):
        if isinstance(sublist, list) and len(sublist) == 0:
            return idx
    return None  # Return None if no empty sublist is found

def process_scientific_notation(answer_str):
    power = False

    # Define a pattern to match various forms of scientific notation
    scientific_pattern = re.compile(r"[\s×xX]?\s?10\^")  # Matches variants like " × 10^", "x 10^", or " 10^"

    # Search for the pattern in the string
    if scientific_pattern.search(answer_str):
        power = True
        # Replace the scientific notation variants with "e"
        answer_str = re.sub(scientific_pattern, "e", answer_str)
        print("new_answer_str:", answer_str)

    return answer_str, power

# Function to use OpenAI to extract numeric answer format and add unit to a prompt
def extract_numeric_answer(answer):
    # # Prompt OpenAI to process the answer and provide only the numeric with unit format
    # prompt = f"""
    # Given the following answer in a scientific question context, extract only the numeric value with unit (if applicable). 
    # Also, use the extracted unit information to specify the unit of the answer in the question.
    
    # Answer: "{answer}"
    
    # Respond with:
    # - Numeric Answer: <numeric value with unit>
    # """
    # Enhanced prompt for OpenAI to handle diverse numeric expressions and ensure ready-for-use format
    prompt = f"""
    Given the following scientific answer, convert it into a clean numeric format with units. 
    If the answer provides multiple values, choose a single value in the most commonly used unit.
    If the answer is in the form of a fraction, multiplier, or scientific notation, process it into a standard numeric expression.
    Also, suggest an additional phrase for the question that specifies the unit or format of the answer if needed.
    
    Answer: "{answer}"
    
    Respond with:
    - Numeric Answer: <numeric value with unit>
    """
    
    response = openai.chat.completions.create(
        model="gpt-4",
        messages=[
            {"role": "system", "content": "You are an assistant skilled at processing scientific answers and formatting."},
            {"role": "user", "content": prompt}
        ],
        temperature = 0
    )
    
    response_text = response.choices[0].message.content
    
    # Extract the "Numeric Answer" and "Question Update" from the response
    numeric_answer_match = re.search(r"Numeric Answer:\s*(.*)", response_text)
    
    numeric_answer = numeric_answer_match.group(1).strip() if numeric_answer_match else answer
    
    return numeric_answer


